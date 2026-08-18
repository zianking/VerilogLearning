module counter(
    input clk,
    input rst_n,
    input plus,
    input minus,
    input setzero,
    input setnum,
    // input [3:0]signal,
    output reg [5:0]num
);
wire [3:0]signal;
assign signal={plus,minus,setzero,setnum};
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        num<=0;
    end
    else begin
        case(signal)
            4'b1000:if(num<60)num<=num+1;
            4'b0100:if(num>0)num<=num-1;
            4'b0010:num<=0;
            4'b0001:num<=23;
            default:num<=num;
        endcase
    end
end
endmodule