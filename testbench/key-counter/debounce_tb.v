`timescale 1ns/1ps
module debounce_tb;
reg clk;
reg reset;
reg key;
wire out;
debounce #(
    .SAMPLE(10)
)
dut(
    .reset(reset),
    .clk(clk),
    .key(key),
    .out(out)
);
initial begin
    clk=0;
    forever #10 clk=~clk;
end
initial begin
    reset=0;
    key=0;
    #100;
    reset=1;
    #500;
    key=1;
    #500;
    key=0;
    #500;
    $finish;
end

endmodule