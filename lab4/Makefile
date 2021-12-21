all: rars imem riscvtest
.PHONY: all

.PHONY: rars
rars: bin/rars.jar
.PRECIOUS: bin/rars.jar
bin/rars.jar:
	curl -L -o bin/rars.jar https://hub.fastgit.org/TheThirdOne/rars/releases/download/v1.5/rars1_5.jar

.PRECIOUS: asm/%.dat
asm/%.dat: asm/%.asm bin/rars.jar
	java -jar bin/rars.jar \
		a \
		mc CompactTextAtZero \
		dump .text HexText $@ $<

asm/%.coe: asm/%.dat
	echo "memory_initialization_radix=16;" > $@ && \
	echo "memory_initialization_vector=" >> $@ && \
	sed '$$!s/$$/,/' $< >> $@ && \
	echo ";" >> $@

sim/adder.vpp: test/adder_tb.v src/adder.v
	iverilog -o $@ $^

sim/adder.vcd: sim/adder.vpp
	cd sim && \
	vvp adder.vpp

.PHONY: adder
adder: sim/adder.vcd
	gtkwave $^ > /dev/null 2>&1 &

.PHONY: riscvtest
riscvtest: sim/riscvtest.vpp asm/riscvtest.dat
	cd sim && \
	vvp -n riscvtest.vpp

RISCV_SOURCES = \
	src/singleriscv.v \
	src/riscvparts.v \
	src/imem.v \
	src/dmem_io.v \
	src/bin2bcd.v \
	src/bcd2bin.v \
	src/alu.v \
	src/adder.v

sim/riscvtest.vpp: test/singleriscv_tb.v $(RISCV_SOURCES)
	iverilog -o $@ $^

.PHONY: imem
imem: asm/main.coe

.PHONY: clean
clean:
	rm -f asm/*.dat asm/*.coe && \
	rm -f sim/*