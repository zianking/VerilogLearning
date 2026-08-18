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
/*  
    rst_n=0;
    key=0;
    #100;
    rst_n=1;
    #500;
    key=1;
    #500;
    key=0;
    #500;
*/
    rst_n=0;
    key=0;
    #100;
    rst_n=1;
    #500;
    //bounce
    key=1;
    #50;
    key=0;
    #100;
    key=1;
    #200;
    key=0;
    #150;
    key=1;
    #100;
    key=0;
    #200;
    key=1;
    //rst_n=0;
    #50;
    //rst_n=1;
    key=0;
    #100;
    //press the key
    key=1;
    #300;
    //release the key
    key=0;
    #100;
    key=1;
    #100;
    key=0;
    #500;
    $finish;

end
endmodule