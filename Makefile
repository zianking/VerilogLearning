TOP = adder4

VERILOG = \
				./vsrc/01_basic_gate/halfadder.v \
				./vsrc/01_basic_gate/fulladder.v \
				./vsrc/02_combinational/fulladder_com.v \
				./vsrc/02_combinational/adder4.v
CSRCS = csrc/sim_main.cpp

all:
	verilator \
		--cc \
		--exe \
		--build \
		--top-module $(TOP) \
		--Mdir build/obj_dir \
		-CFLAGS "-I$(PWD)/build/obj_dir" \
		$(VERILOG) \
		$(CSRCS)
clean:
	rm -rf build/obj_dir
