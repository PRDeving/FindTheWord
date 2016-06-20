(defvar words '(
                "potato" 
                "tomato" 
                "pumpkin" 
                "car" 
                "horse" 
                "house" 
                "bakery" 
                "motocycle" 
                "stairs" 
                "window"
                "door"
                "bed"
                "sun"
                "beer"
                "sky"
                "watermelon"
                "apple"
                "kiwi"
                ))

(setf *random-state* (make-random-state t)) ; Creia que era un lenguaje dinamico y resulta que tengo que hacer el seed de random -.-

; STATE
(setq found nil)
(setq secret (nth (random (length words)) words))

; SAID AND OPORTUNITIES
(setq said '(0))
(setq op 5)


; Ojala lisp molase mas y pudiese system('cls')
; TODO: me niego a creer que no tenga un cli-clear
(defun clear()
  (loop for x from 0 to 50 do
    (terpri)
  )
)


(defun checkCharacter(char)
  (push (aref char 0) (cdr (last said)))
  (if (string= char secret)
    (setq found T)
    (if (= (length char) 1)
      (if (search char secret)
        (progn (format t "Yep, it has ~s" char) (terpri))
        (write-line "Nope")
      )
      ;TODO: esta mierda queda en el infinito por el orden de impresion
      (write-line "To many characters :P")
    )
  )
)

; (write-line secret)

(defun displayWord()
  (clear)
  (format t "You have ~d oportunities left" op)
  (terpri)
  (princ "The secret word is: ") 
  (terpri)
  (loop for x from 0 to (- (length secret) 1) do
    (if (find (aref (subseq secret x (+ x 1)) 0) said)
      (princ (subseq secret x (+ x 1)))
      (write '*)
    )
  )
  (terpri)
)
 
(clear)
(write-line "There's a secret word to find")
(write-line "Type a letter and press return to know if it's in the word")
(write-line "If you know the secret word, write it down and press return")
(write-line "But be fast! you only have 5 oportunities")
(write-line "You can exit whenever you want by typing 'exit' and pressing return")
(terpri)
(write-line "Write 'ok' and press return to play...")
(if (string= (read-line) "ok")
  (setq looping T)
  (quit)
)

(loop while looping do
  (displayWord)
  (write-line "Does it has a ...?")
  (setq input (read-line))

  ; Comprueba exit
  (if (string= input "exit")
    (setq looping nil)
    (checkCharacter input)
  )

  (if found
    (progn
      (format t "YESS!!, it was ~s" secret)
      (setq looping nil)
    )
    (setq op (- op 1))
  )

  (if (< op 1)
    (progn
      (format t "Yo have no left oportuninties, the secret word was ~s" secret)
      (setq looping nil)
    )
    ()
  )
  (terpri)
  (terpri)
)
