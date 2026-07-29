TOP = encoder8to3 

VERILOG = \
				./vsrc/02_combinational/encoder4to2.v \
				./vsrc/02_combinational/encoder8to3.v
CSRCS = csrc/sim_encoder8to3.cpp

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
