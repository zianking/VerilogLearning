TOP = decoder2to4

VERILOG = \
				./vsrc/02_combinational/decoder2to4.v
CSRCS = csrc/sim_decoder2to4.cpp

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
