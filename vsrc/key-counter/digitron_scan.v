module digitron_scan
#(
    parameter CLK_FREQ=50000000,
    parameter SCAN_FREQ=2000,
    parameter COUNT=CLK_FREQ/SCAN_FREQ
)
(
    input rst_n,
    input clk,
    input [6:0]ones,
    input [6:0]tens,
    input pointwire,
    output reg [3:0]cs,
    output reg [6:0]digitout,
    output reg point
);
reg [16:0]cnt;
reg choice=0;
always @(posedge clk or negedge rst_n)begin
    if(!rst_n) cnt<=0;
    else begin
        if(cnt<COUNT) cnt<=cnt+1;
        else cnt<=0;
    end
end
always @(posedge clk or negedge rst_n)begin
    if(!rst_n) choice<=0;
    else begin
        if(cnt==0) choice<=~choice;
        else choice<=choice;
    end
end
always @(*)begin
    if(choice==0) cs=4'b1110;
    else cs=4'b1101;
end
always @(*)begin
    case(choice)
        0:digitout=ones;
        1:digitout=tens;
    endcase
    point=pointwire;
end
endmodule