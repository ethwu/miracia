#lang racket
(require pollen/setup
         pollen/tag
         txexpr)
(provide (all-defined-out))

; italic emphasis
(define-tag-function (italic attrs elems)
                     (case (current-poly-target)
                       [(html) (txexpr 'em attrs elems)]
                       [else `("_" ,@elems "_")]))
(define emph italic)

; bold emphasis
(define-tag-function (bold attrs elems)
                     (case (current-poly-target)
                       [(html) (txexpr 'strong attrs elems)]
                       [else `("*" ,@elems "*")]))
(define strong bold)

; small caps emphasis
(define-tag-function (small-caps attrs elems)
                     (case (current-poly-target)
                       [(html) (txexpr 'span `((class "small-caps") ,@attrs) elems)]
                       [else (map string-upcase elems)]))
(define impt small-caps)

; definition of terms
(define-tag-function (term attrs elems)
                     (case (current-poly-target)
                       [(html) (txexpr 'dfn attrs elems)]
                       [else `(emph ,@attrs ,@elems)]))

; hyperlinks
; adapted from https://github.com/mbutterick/pollen-tfl/tree/master/scribblings/pollen-tfl.scrbl
; (define-tag-function
;  (link attrs
;        elems)
;  (case (current-poly-target)
;    [(html)
;     (attr-join (list 'a attrs (if (empty? (cdr elems)) (car elems) (cdr elems))) 'href (car elems))]
;    [else ('@ (if (not (empty? elems)) (cons (cdr elems) " ") empty) `("<" ,(car elems) ">"))]))

; hyperlink with text
(define-tag-function (link attrs
                           elems)
                     (case (current-poly-target)
                       [(html) (html-a attrs (car elems) (cdr elems))]
                       [else (list (cdr elems) (url (car elems)))]))

; hyperlink
(define-tag-function (url attrs elems)
                     (case (current-poly-target)
                       [(html) (html-a attrs elems)]
                       [else `("<" ,elems ">")]))

; html <a> tag
(define (html-a attrs url text)
  (attr-join (txexpr 'a attrs text) "href" url))

; use lining figures
(define (lining-figures . elems)
  (txexpr 'span '((class "lining-figures")) elems))
