`timescale 1ns/1ps
module top_tb;
reg clk;
reg rst_n;
reg keyplus;
reg keyminus;
reg keysetzero;
reg keysetnum;
reg startswitch;
wire uartout;
wire point;
wire [6:0]digitout;
wire [3:0]cs;
top #(
    .DEBOUNCE_SAMPLE(10),
    .CLK_FREQ(50000000),
    .BAUD_RATE(1000000),
    .SCAN_FREQ(1000000)   
)
dut(
    .clk(clk),
    .rst_n(rst_n),
    .keyplus(keyplus),
    .keyminus(keyminus),
    .keysetzero(keysetzero),
    .keysetnum(keysetnum),
    .startswitch(startswitch),
    .uartout(uartout),
    .point(point),
    .digitout(digitout),
    .cs(cs)
);
initial begin
    clk=0;
    forever #10 clk=~clk;
end
initial begin
    rst_n=0;
    keyplus=1;
    keyminus=1;
    keysetzero=1;
    keysetnum=1;
    startswitch=0;
    #100;
    rst_n=1;
    #200;
    keyplus=0;
    #1000;
    keyplus=1;
    #1000;
    $finish;    
end
endmodule