;;; ----------------------------------------------------------------------------
;;; CONSTANTS

;; PPU registers

; https://www.nesdev.org/wiki/PPU_registers#PPUCTRL
PPUCTRL		= $2000
;; 7  bit  0
;; ---- ----
;; VPHB SINN
;; |||| ||||
;; |||| ||++- Base nametable address
;; |||| ||    (0 = $2000; 1 = $2400; 2 = $2800; 3 = $2C00)
;; |||| |+--- VRAM address increment per CPU read/write of PPUDATA
;; |||| |     (0: add 1, going across; 1: add 32, going down)
;; |||| +---- Sprite pattern table address for 8x8 sprites
;; ||||       (0: $0000; 1: $1000; ignored in 8x16 mode)
;; |||+------ Background pattern table address (0: $0000; 1: $1000)
;; ||+------- Sprite size (0: 8x8 pixels; 1: 8x16 pixels – see PPU OAM#Byte 1)
;; |+-------- PPU master/slave select
;; |          (0: read backdrop from EXT pins; 1: output color on EXT pins)
;; +--------- Generate an NMI at the start of the
;;            vertical blanking interval (0: off; 1: on)

; https://www.nesdev.org/wiki/PPU_registers#PPUMASK
PPUMASK		= $2001
;; 7  bit  0
;; ---- ----
;; BGRs bMmG
;; |||| ||||
;; |||| |||+- Greyscale (0: normal color, 1: greyscale)
;; |||| ||+-- 1: Show background in leftmost 8 pixels of screen, 0: Hide
;; |||| |+--- 1: Show sprites in leftmost 8 pixels of screen, 0: Hide
;; |||| +---- 1: Enable background rendering
;; |||+------ 1: Enable sprite rendering
;; ||+------- Emphasize red (green on PAL/Dendy)
;; |+-------- Emphasize green (red on PAL/Dendy)
;; +--------- Emphasize blue

; https://www.nesdev.org/wiki/PPU_registers#PPUSTATUS
PPUSTATUS	= $2002

; https://www.nesdev.org/wiki/PPU_registers#OAMADDR
; OAMADDR - Sprite RAM address ($2003 write)
; Write the address of OAM you want to access here.
; Most games just write $00 here and then use OAMDMA.
; (DMA is implemented in the 2A03/7 chip and works by repeatedly writing to OAMDATA)
OAMADDR		= $2003

; https://www.nesdev.org/wiki/PPU_registers#OAMDATA
; OAMDATA - Sprite RAM data ($2004 read/write)
; Write OAM data here. Writes will increment OAMADDR after the write; reads do not.
; Reads during vertical or forced blanking return the value from OAM at that address.
OAMDATA		= $2004

; https://www.nesdev.org/wiki/PPU_registers#PPUSCROLL
PPUSCROLL	= $2005

; https://www.nesdev.org/wiki/PPU_registers#PPUADDR
PPUADDR		= $2006

; https://www.nesdev.org/wiki/PPU_registers#PPUDATA
PPUDATA		= $2007

;;; Other IO registers.
; https://www.nesdev.org/wiki/PPU_registers#OAMDMA
OAMDMA		= $4014

; https://www.nesdev.org/wiki/IRQ
DMCIRQ      = $4010

;; APU registers

; https://www.nesdev.org/wiki/APU#Status_($4015)
APUSTATUS	= $4015

CONTROLLER  = $4016

BTN_RIGHT   = %00000001
BTN_LEFT    = %00000010
BTN_DOWN    = %00000100
BTN_UP      = %00001000
BTN_START   = %00010000
BTN_SELECT  = %00100000
BTN_B       = %01000000
BTN_A       = %10000000