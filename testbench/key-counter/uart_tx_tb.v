`timescale 1ns/1ps
module uart_tx_tb;
reg clk;
reg rst_n;
reg [5:0]num;
reg startswitch;
wire out;
uart_tx #(
    .BAUD_RATE(1000000)
)
dut(
    .rst_n(rst_n),
    .clk(clk),
    .num(num),
    .startswitch(startswitch),
    .out(out)
);
initial begin
    clk=0;
    forever #10 clk=~clk;
end
initial begin
    rst_n=0;
    num=0;
    startswitch=0;
    #200;
    rst_n=1;
    num=10;
    #20005;
    startswitch=1;
    num=10;
    #30000;
    num=20;
    #30000;
    num=23;
    #30000;
    num=31;
    #30000;
    startswitch=0;
    $finish;
end
endmodule