TOP = alu4 

VERILOG = \
				./vsrc/02_combinational/alu4.v
CSRCS = ./csrc/02_combinational/sim_alu4.cpp

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
