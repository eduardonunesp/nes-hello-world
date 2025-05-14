;;; ----------------------------------------------------------------------------
;;; NMI

.include "constants.s"

.segment "ZEROPAGE"
.importzp sleeping
.importzp ppuctrl_settings

.segment "CODE"
.import sub_arg_1
.export nmi_handler
.proc nmi_handler
	;; save registers
	pha
	txa
	pha
	tya
	pha

	;; render
	lda #$00
	sta OAMADDR
	lda #$02
	sta OAMDMA

	;; set PPUCTRL
	lda ppuctrl_settings
	sta PPUCTRL

	;; all done
	lda #$00
	sta sleeping

	;; restore registers
	pla
	tay
	pla
	tax
	pla

	rti
.endproc ; nmi