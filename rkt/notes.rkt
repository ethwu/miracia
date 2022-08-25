#lang racket
(require counter
         pollen/decode
         pollen/setup
         pollen/tag
         txexpr
         "constants.rkt")
(provide sidenote
         margin-caption
         margin-figure
         margin-note)

; helper function for generating the note functions
(define (make-note type [marker ""] [text-tag 'span] [wrapper-tag '@] [counter-name type])
  ; counter for when the note anchor is not provided
  (define next-note-anchor (make-counter 0))
  (define-tag-function
   (note-callback attrs elems)
   (define anchor (dict-ref attrs 'anchor (format "~a-~a" counter-name (next-note-anchor 'run))))
   (list
    wrapper-tag
    (let* ([label-el (txexpr 'label empty (list marker))]
           [label-el (attr-join label-el "for" (~a anchor))]
           [label-el (attr-join label-el
                                "class"
                                (format "margin-toggle~a"
                                        (if (equal? 'sidenote type) " sidenote-number" "")))])
      label-el)
    (txexpr 'input `((id ,(~a anchor)) (class "margin-toggle") (type "checkbox")) empty)
    (let* ([sidenote-el
            (txexpr text-tag (filter (λ (entry) (not (equal? 'anchor (car entry)))) attrs) elems)]
           [sidenote-el (attr-join sidenote-el "class" (~a type))])
      sidenote-el)))
  note-callback)

; numbered sidenote
(define sidenote (make-note 'sidenote))
; unnumbered margin note
(define margin-note (make-note 'marginnote margin-note-symbol))

; margin figures
(define margin-figure (make-note 'marginnote margin-note-symbol 'span 'figure "margin-figure"))
; figure captions in the margin
(define margin-caption (make-note 'marginnote margin-note-symbol 'figcaption '@ "margin-caption"))

; ; margin figures
; (define margin-figure-float (make-note 'marginnote margin-note-symbol 'figure "margin-figure"))
; (define-tag-function (margin-figure attrs elems) (txexpr 'figure empty (apply margin-figure-float attrs elems)))
; ; figure caption in margin
; (define margin-caption (make-note 'marginnote margin-note-symbol 'figcaption "margin-caption"))
