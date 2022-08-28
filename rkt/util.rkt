#lang racket
(require racket/path
         pollen/core
         pollen/render
         pollen/setup
         pollen/tag
         txexpr)
(provide (all-defined-out))

(define (get-here) (select-from-metas 'here-path (current-metas)))
(define (here-dirname) (path-only (get-here)))

; an empty `txexpr`
(define empty-tag (txexpr '@))

(define (map-values proc lst)
  (foldl (lambda (el acc) (append (proc el) acc)) '() lst))

(define (attrs-map-values attrs proc)
  (append* (dict-map attrs proc)))

(define (map-attributes-noop key vals)
  (list (cons key vals)))
(define (map-symbols-noop s)
  (list (list s "")))
(define (tag-body-default tag attrs elems)
  (txexpr tag (combine-attrs attrs) elems))
; function `map-symbols`
; Create a tag function.
; Arguments to the tag function are handled by the two mapping functions:
;   - `#:kws`: Maps a dictionary of keyword arguments and their values to an attribute list.
;   - `#:sym`: Maps symbols passed at the beginning of the argument list to an attribute list.
;   - `#:att`: Attribute list included by default.
;   - `#:body`: Creates a `txexpr` from the tag, attribute list, and elements.
;     May use `combine-attrs` to combine duplicate attributes.
(define/contract
 (create-tag [tag '@]
             #:kws [map-attributes map-attributes-noop]
             #:sym [map-symbols map-symbols-noop]
             #:att [additional empty]
             #:body [body tag-body-default])
 (() (txexpr-tag? #:kws (symbol? any/c . -> . txexpr-attrs?)
                  #:sym (symbol? . -> . txexpr-attrs?)
                  #:att txexpr-attrs?
                  #:body (txexpr-tag? txexpr-attrs? txexpr-elements? . -> . txexpr?))
     . ->* .
     procedure?)
 (define-tag-function
  (tag-function attrs elems)
  (let-values ([(symbs elems) (splitf-at elems symbol?)])
    (body tag
          (append (map-values map-symbols symbs) (attrs-map-values attrs map-attributes) additional)
          elems)))
 tag-function)

; call a function on some arg if they fit the passed type predicate, or return false
(define (get-as type? callback arg)
  (and (type? arg) (callback arg)))

; include the contents of another file in this one; the parent file will not count changes in the child file as marking it for recompilation
(define (include file)
  `(@ ,@(cdr (get-doc file))))
; render an unrendered file and include it. path is resolved relative to the project root
(define (render-include file) (list '@ (render (get-here) (path->complete-path file (current-project-root)))))

; convert a pair to a list
(define (pair->list p)
  (if (and (pair? p) (not (list? p))) (list (car p) (cdr p)) p))

(define (attrs-has? attrs k v)
  (ormap (lambda (el) (and (equal? (car el) k) (equal? (cadr el) v))) attrs))
(define attrs-ref attr-ref)
(define (attrs-set attrs k v)
  (hash->attrs (dict-set (attrs->hash attrs) k v)))

; combine attributes with the same key by joining their values with spaces
(define (combine-attrs attrs)
  ; (txexpr-attrs? . -> . txexpr-attrs?)
  (hash->attrs
   (foldl
    (lambda (next acc)
      (hash-update acc
                   (car next)
                   (lambda (existing)
                     (if (equal? existing "") (~a (cadr next)) (format "~a ~a" (cadr next) existing)))
                   ""))
    (make-immutable-hash)
    attrs)))

; Create a path to the given path.
(define (build-pollen-path . elements)
  (simple-form-path (apply build-path
                           (filter identity
                                   (map (lambda (el) (if (symbol? el) (symbol->string el) el))
                                        elements)))))

; Resolve a relative path for a file in the `pm/` directory.
(define (rel-path path)
  (find-relative-path (here-dirname)
                      (path->complete-path path)))

; Get the title of a page, if it is defined. Otherwise, get the file name.
(define (page-title page)
  (or (cond [(path? page)   (select 'h1 (resolve-path page))]
            [(string? page) (select 'h1 (string->symbol page))]
            [(symbol? page) (select 'h1 page)]
            [else page])
      ""))
