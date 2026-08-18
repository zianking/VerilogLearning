`timescale 1ns/1ps
module debounce_tb;
reg clk;
reg rst_n;
reg key;
wire out;
debounce #(
    .SAMPLE(10)
)
dut(
    .rst_n(rst_n),
    .clk(clk),
    .key(key),
    .out(out)
);
initial begin
    clk=0;
    forever #10 clk=~clk;
end
initial begin
    rst_n=0;
    key=0;
    #100;
    rst_n=1;
    #500;
    key=1;
    #500;
    key=0;
    #500;
    $finish;
end
endmodule