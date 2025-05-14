OBJS := main.o reset.o nmi.o irq.o zeropage.o controller.o player.o
PROG := hello_world.nes
OUT  := $(PROG)
EMU  := fceux

all: $(OUT)

clean:
	rm -f $(OBJS) $(OUT)
	rm -f *.fdb *.labels.txt *.map.txt *.nes.dbg

.PHONY: all clean build

# Assemble

%.o: %.s
	ca65 $< -g -o $@

# Link

$(PROG): nes.cfg $(OBJS)
	ld65 -C nes.cfg $(OBJS) -o $@ -m main.map.txt -Ln main.labels.txt --dbgfile main.nes.dbg

build: $(PROG)

run: $(PROG)
	$(EMU) $<
