;;; ----------------------------------------------------------------------------
;;; RESET

.include "constants.s"

.import main

.export reset_handler
.proc reset_handler
	sei ; disable interrupts
	cld ; clear decimal mode

	;; initialize stack pointer with $ff
	ldx #$ff
	txs

	;; initialize PPU and APU
	ldx #0
	stx PPUCTRL   ; $00 -> disable nmi
	stx PPUMASK   ; $00 -> disable rendering
	stx APUSTATUS ; $00 -> disable sound
	stx DMCIRQ    ; $00 -> disable dmc irq

	;; wait for first vblank
	:	bit PPUSTATUS
		bpl :-

	;; clear all RAM to 0
	lda #0
	ldx #0
	:	sta $0000, x
		sta $0100, x
		sta $0200, x
		sta $0300, x
		sta $0400, x
		sta $0500, x
		sta $0600, x
		sta $0700, x
		lda #$fe
		sta $0200, x
		inx
		bne :-

	jmp main
.endproc ; reset
