;;; ----------------------------------------------------------------------------
;;; IRQ

.export irq_handler
.proc irq_handler
	rti
.endproc ; irq