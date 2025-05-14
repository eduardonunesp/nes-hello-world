;;; ----------------------------------------------------------------------------
;;; HEADER

; iNES ROM image header
.segment "HEADER"
	;; nes header identifier
	.byte $4e, $45, $53, $1a ;; N, E, S, BRK

	;; size of PRG in units of 16 KiB.
	;; number of 16KB PRG-ROM banks
	.byte $02

	;; size of CHR in units of 8 KiB.
	;; number of 8KB CHR-ROM banks
	.byte $01

	;; horizontal mirroring, no save RAM, no mapper
	.byte %00000000

	;; No special-case flags set, no mapper
	.byte %00000000

	;; No PRG-RAM present
	.byte $00

	;; NTSC format
	.byte $00

; "nes" linker config requires a STARTUP section, even if it's empty
.segment "STARTUP"

.segment "VECTORS"
  ;; when an NMI happens (once per frame if enabled) the label nmi:
  .addr nmi_handler
  ;; when the processor first turns on or is reset, it will jump to the label reset:
  .addr reset_handler
  ;; external interrupt IRQ (unused)
  .addr irq_handler

.segment "CHARS"
.incbin "graphics.chr"