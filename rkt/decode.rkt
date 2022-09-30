#lang racket
(require hyphenate
         pollen/decode
         pollen/tag
         pollen/misc/tutorial
         txexpr
         "notes.rkt"
         "util.rkt")
(provide root)

; https://www.jonashietala.se/blog/2020/05/03/how_i_wrote_my_book_using_pollen/
(define (ellipses x)
  (string-replace x "..." "…"))

(define (de-indexify x)
  (string-replace x "/index.html" ""))

; https://docs.racket-lang.org/pollen-tfl/_pollen_rkt_.html
(define no-hyphens-attr '(hyphens "none"))
(define (hyphenate-block block-tx)
  (define (no-hyphens? tx)
    (or (member (get-tag tx) '(th h1 h2 h3 h4 style script)) (member no-hyphens-attr (get-attrs tx))))
  (hyphenate block-tx #:min-left-length 3 #:min-right-length 3 #:omit-txexpr no-hyphens?))

; replace `caption`s under `figure`s with `figcaption`s when targeting html
(define (fix-captions tx)
  (define (txexpr-with-tag? tx tag)
    (and (txexpr? tx) (equal? (get-tag tx) tag)))
  (if (txexpr-with-tag? tx 'figure)
      (txexpr 'figure
              (get-attrs tx)
              (decode-elements (get-elements tx)
                               #:txexpr-tag-proc
                               (λ (tag) (if (equal? 'caption tag) 'figcaption tag))))
      tx))

; Decode the root node.
(define (root . elems)
  (let* ([excluded (λ args `(list pre style script ,@args))]
         [elems (decode-elements elems #:txexpr-proc fix-captions #:exclude-tags (excluded))]
         [elems (decode-elements elems
                                 #:txexpr-elements-proc decode-paragraphs
                                 #:exclude-tags (excluded 'code 'figure 'table 'link 'div))]
         [elems (decode-elements
                 elems
                 #:block-txexpr-proc hyphenate-block
                 #:string-proc (compose1 smart-quotes smart-dashes ellipses de-indexify)
                 #:exclude-tags (excluded 'code 'tt 'kbd 'samp))])
    (txexpr 'article empty elems)))
