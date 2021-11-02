all: bcd2bin
.PHONY: all

.PHONY: bcd2bin
.PHONY: simple

bcd2bin.vpp: bcd2bin_tb.v bcd2bin.v bin2bcd.v
	iverilog -o bcd2bin.vpp bcd2bin_tb.v bcd2bin.v bin2bcd.v

simple.vpp: simple_tb.v simple.v
	iverilog -o simple.vpp simple_tb.v simple.v

%.vcd: %.vpp
	vvp $<

bcd2bin: bcd2bin.vcd
	gtkwave bcd2bin.vcd > /dev/null 2>&1 &

simple: simple.vcd
	gtkwave simple.vcd > /dev/null 2>&1 &

.PHONY: clean
clean:
	rm -f *.vpp *.vcd