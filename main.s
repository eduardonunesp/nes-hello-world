;;; ----------------------------------------------------------------------------
;;; MAIN

.include "constants.s"
.include "header.s"

.segment "CODE"

.importzp sleeping
.importzp ppuctrl_settings
.importzp player_x, player_y

.import irq_handler
.import nmi_handler
.import reset_handler
.import read_controller
.import update_player
.import draw_player

.export main
.proc main
	;; write a palette
	ldx PPUSTATUS
	ldx #$3f
	stx PPUADDR
	ldx #$00
	stx PPUADDR

	;; load palette
	ldx #0
	:	lda palettes, x
		sta PPUDATA
		inx
		cpx #20
		bne :-

	;; wait for second vblank
	:	bit PPUSTATUS
		bpl :-

	;; enable rendering
	lda #%10010000
	sta ppuctrl_settings
	sta PPUCTRL
	lda #%00011110
	sta PPUMASK

	lda #$80
	sta player_x
	lda #$a0
	sta player_y

	;; game loop
	gameloop:
		jsr read_controller
		jsr update_player
		jsr draw_player

		lda ppuctrl_settings
		eor #%00000010 ; flip bit 1 to its opposite
		sta ppuctrl_settings

		;; done processing; wait for next vblank
		inc sleeping
		sleep:
			lda sleeping
			bne sleep

		jmp gameloop
.endproc ; main

.segment "RODATA"

palettes:
	.byte $0f, $12, $23, $27
	.byte $0f, $2b, $3c, $39
	.byte $0f, $0c, $07, $13
	.byte $0f, $19, $09, $29

	.byte $0f, $2d, $10, $15
	.byte $0f, $09, $1a, $2a
	.byte $0f, $01, $11, $31
	.byte $0f, $19, $09, $29