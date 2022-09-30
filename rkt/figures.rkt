#lang racket
(require pollen/setup
         pollen/tag
         txexpr
         "constants.rkt"
         "util.rkt")
(provide (all-defined-out))

; figure wrapper
(define figure (default-tag-function 'figure))

; images
; https://docs.racket-lang.org/pollen-tfl/_pollen_rkt_.html
(define image
  (make-keyword-procedure (λ (attr-keys attr-vals url)
                            (case (current-poly-target)
                              [(html)
                               `(img ((src ,(format "~a" (build-path image-location url)))
                                      ,@(map cons attr-keys attr-vals)))]
                              [else `("![" ,url "]")]))))

; map attributes for rowspans and colspans for table headers and table elements
(define (map-table-spans key val)
  (match key
    [(or 'rspan 'rowspan) `((rowspan ,(~a (car val))))]
    [(or 'cspan 'colspan) `((colspan ,(~a (car val))))]
    [else '((key val))]))

; table header
(define th
  (create-tag 'th
              #:kws map-table-spans
              #:sym (lambda (sym)
                      (match sym
                        [(or 'c 'col 'column) '((scope "col"))]
                        [(or 'r 'row) '((scope "row"))]
                        [else `((,sym ""))]))))

; table element
(define te (create-tag 'td #:kws map-table-spans))

; Render a tsv.
(define tsv
  (create-tag 'table
    #:body (λ (tag attrs elems)
              (let* ([elems (string-split (string-append* elems) "\n")]
                     [headers (string-split (car elems) "\t")]
                     [data-rows (cdr elems)])
                    (txexpr tag (combine-attrs attrs)
                           (list `(thead (tr ,@(map (λ (header) `(th ,header)) headers)))
                                 `(tbody ,@(map (λ (data-row)
                                                    `(tr ,@(map (λ (data) `(td ,data))
                                                            (string-split data-row "\t"))))
                                                  data-rows))))))))