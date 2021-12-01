# Used for iverilog simulation

all: gtkwave
.PHONY: all

sim/stringreco.vpp: src/stringreco_tb.v src/stringreco.v src/bin2bcd.v
	iverilog -o sim/stringreco.vpp src/stringreco_tb.v src/stringreco.v src/bin2bcd.v

sim/stringreco.vcd: sim/stringreco.vpp
	cd sim && \
	vvp stringreco.vpp

.PHONY: gtkwave
gtkwave: sim/stringreco.vcd
	gtkwave sim/stringreco.vcd > /dev/null 2>&1 &

.PHONY: clean
clean:
	rm sim/*