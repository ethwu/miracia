#lang racket
(require txexpr
         "rkt/main.rkt")
(provide (all-defined-out)
         (all-from-out "rkt/main.rkt"))

(module setup racket/base
  (provide (all-defined-out))
  (define poly-targets '(html txt)))

; Create a pair of brackets that can be displayed using the `.ghost` CSS class
; instead.
(define (ghost-bracket lb rb)
  (lambda (tag attrs elems)
    (txexpr tag
            (combine-attrs attrs)
            (if (attrs-has? attrs 'class "ghost") elems `(,lb ,@elems ,rb)))))

; Text in the IPA.
(define ipa
  (create-tag 'span
              #:sym (lambda (s)
                      (match s
                        [(or 'w 'wide) '((class "wide"))]
                        [(or 'n 'narrow) '((class "narrow"))]
                        [(or 'g 'ghost) '((class "ghost"))]
                        [else '()]))
              #:att '((class "ipa"))
              #:body (lambda (tag attrs elems)
                       (txexpr tag
                               (combine-attrs attrs)
                               (if (attrs-has? attrs 'class "ghost")
                                   elems
                                   (cond
                                     [(attrs-has? attrs 'class "wide") `("/" ,@elems "/")]
                                     [(attrs-has? attrs 'class "narrow") `("[" ,@elems "]")]
                                     [else elems]))))))
; Orthographic representation.
(define orth
  (create-tag 'span
              #:sym (lambda (s)
                      (match s
                        [(or 'g 'ghost) '((class "ghost"))]
                        [else '()]))
              #:att '((class "orth"))
              #:body (ghost-bracket "⟨" "⟩")))
; A pair of an IPA text and its corresponding orthographic representation.
(define (opair first_ (second_ #f))
  (txexpr* '@
           empty
           (ipa 'ghost 'wide (if second_ second_ first_))
           (if second_ (list '@ 'nbsp (orth 'g first_)) empty-tag)))
