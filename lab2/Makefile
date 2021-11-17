# Used for iverilog simulation

all: gtkwave
.PHONY: all

sim/stopwatch.vpp: src/stopwatch_tb.v src/stopwatch.v src/gy163.v
	iverilog -o sim/stopwatch.vpp src/stopwatch_tb.v src/stopwatch.v src/gy163.v

sim/stopwatch.vcd: sim/stopwatch.vpp
	cd sim && \
	vvp stopwatch.vpp

.PHONY: gtkwave
gtkwave: sim/stopwatch.vcd
	gtkwave sim/stopwatch.vcd > /dev/null 2>&1 &

.PHONY: clean
clean:
	rm sim/*