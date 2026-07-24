TOPNAME=mux
BUILD_DIR=./build
VERILATOR=verilator
all:
	$(VERILATOR)  --cc \
	--exe \
	--build \
	--top-module $(TOPNAME) \
	--Mdir $(BUILD_DIR)/obj_dir \
	vsrc/$(TOPNAME).v \
	csrc/sim_main.c

run:
	./$(BUILD_DIR)/obj_dir/V$(TOPNAME)

clean:
	rm -rf $(BUILD_DIR)
