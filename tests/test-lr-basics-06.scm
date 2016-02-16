;;; test-lr-basics-06.scm --
;;
;; Derived from test-lr-basics-05.scm.
;; Check if parser initializes all of its local
;; variables, so that it be called multiple times.
;;

(load "common-test.scm")

(define (doit . tokens)
  (let ((parser (lalr-parser (expect: 0)
			     (A)
			     (e (e A) : (cons $2 $1)
				(A)   : (list $1)
				()    : 0))))
    (parser (make-lexer tokens) error-handler)
    (parser (make-lexer tokens) error-handler)
    ))
    

(check
    (doit)
  => 0)

(check
    (doit (make-lexical-token 'A #f 1))
  => '(1))

(check
    (doit (make-lexical-token 'A #f 1)
	  (make-lexical-token 'A #f 2))
  => '(2 1))

(check
    (doit (make-lexical-token 'A #f 1)
	  (make-lexical-token 'A #f 2)
	  (make-lexical-token 'A #f 3))
  => '(3 2 1))

;;; end of file
