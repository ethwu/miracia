#lang racket
(require pollen/setup
         pollen/tag
         txexpr)
(provide (all-defined-out))
(provide title
         subtitle
         section
         subsection)

; title of the document
(define-tag-function (title attrs elems)
                     (case (current-poly-target)
                       [(html) (txexpr 'h1 attrs elems)]
                       [else (txexpr 'title attrs (map string-upcase elems))]))

; subtitle of the document
(define-tag-function (subtitle attrs elems)
                     (case (current-poly-target)
                       [(html) (txexpr 'p (cons '(class "subtitle") attrs) elems)]
                       [else (txexpr 'subtitle attrs `("-- " ,@elems " --"))]))

; make a heading tag
(define (make-heading html-tag text-delimiters)
  (make-keyword-procedure (λ (attr-keys attr-vals . elems)
                            (case (current-poly-target)
                              [(html) (txexpr html-tag (map cons attr-keys attr-vals) elems)]
                              [else `(,text-delimiters " " ,@elems " " ,text-delimiters)]))))

; section heading
(define heading (make-heading 'h2 "=="))
; low-level heading
(define subheading (make-heading 'h3 "--"))

; make a section tag
; @section["Heading"]{Lorum ipsum dolor...}
(define (make-section heading)
  (make-keyword-procedure (λ (attr-keys attr-vals head . elems)
                            `(section ,(map cons attr-keys attr-vals) ,(heading head) ,@elems))))

; sections
(define section (make-section heading))
; subsections
(define subsection (make-section subheading))
