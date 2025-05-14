;;; ----------------------------------------------------------------------------
;;; ZEROPAGE

.segment "ZEROPAGE"

.exportzp player_x
player_x: .res 1

.exportzp player_y
player_y: .res 1

.exportzp sub_arg_1
sub_arg_1: .res 1

.exportzp sub_arg_2
sub_arg_2: .res 1

.exportzp sub_arg_3
sub_arg_3: .res 1

.exportzp pad_1
pad_1: .res 1

.exportzp sleeping
sleeping: .res 1

.exportzp ppuctrl_settings
ppuctrl_settings: .res 1