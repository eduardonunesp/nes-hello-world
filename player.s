;;; ----------------------------------------------------------------------------
;;; PLAYER

.include "constants.s"

.importzp player_x
.importzp player_y
.importzp pad_1

.export update_player
.proc update_player
	lda pad_1       ; load button presses
	and #BTN_LEFT   ; filter out all but left
	beq check_right ; if result is zero, left not pressed
	dec player_x    ; if the branch is not taken, move player left

	check_right:
		lda pad_1
		and #BTN_RIGHT
		beq check_up
		inc player_x

	check_up:
		lda pad_1
		and #BTN_UP
		beq check_down
		dec player_y

	check_down:
		lda pad_1
		and #BTN_DOWN
		beq done_checking
		inc player_y

	done_checking:

	rts
.endproc

.export draw_player
.proc draw_player
	;; write sprite data
	ldx #0
	:	lda sprites, x
		sta $0200, x
		inx
		cpx #32
		bne :-

	;; top left tile:
	lda player_y
	sta $0200
	lda player_x
	sta $0203

	;; top right tile (x + 8):
	lda player_y
	sta $0204
	lda player_x
	clc
	adc #$08
	sta $0207

	;; bottom left tile (y + 8):
	lda player_y
	clc
	adc #$08
	sta $0208
	lda player_x
	sta $020b

	;; bottom right tile (x + 8, y + 8)
	lda player_y
	clc
	adc #$08
	sta $020c
	lda player_x
	clc
	adc #$08
	sta $020f

	rts
.endproc

sprites:
	;;    Y    C    A          X
	.byte $70, $05, %00000000, $80
	.byte $70, $05, %01000000, $88
	.byte $78, $07, %00000000, $80
	.byte $78, $07, %01000000, $88