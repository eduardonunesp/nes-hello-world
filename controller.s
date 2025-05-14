;;; ----------------------------------------------------------------------------
;;; CONTROLLER

.include "constants.s"

.importzp pad_1

.export read_controller
.proc read_controller
	pha
	txa
	pha
	php

	;; write a 1, then a 0, to CONTROLLER
	;; to latch button states
	lda #$01
	sta CONTROLLER
	lda #$00
	sta CONTROLLER

	lda #%00000001
	sta pad_1

	:	lda CONTROLLER  ; Read next button's state
		lsr A           ; Shift button state right, into carry flag
		rol pad_1       ; Rotate button state from carry flag onto right side of pad1 and leftmost 0 of pad1 into carry flag
		bcc :-          ; Continue until original "1" is in carry flag

	plp
	pla
	tax
	pla

	rts
.endproc
