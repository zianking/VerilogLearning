module uart_tx
#(
    parameter IDLE=4'b0001,
    parameter START=4'b0010,
    parameter DATA=4'b0100,
    parameter STOP=4'b1000,
    parameter CLK_FREQ=50000000,
    parameter BAUD_RATE=9600,
    parameter CLKS_PER_BIT=CLK_FREQ/BAUD_RATE
)
(
    input rst_n,
    input clk,
    input [5:0]num,
    input startswitch,
    output reg out
);
reg [5:0]numstored=0;
reg [3:0]CS=IDLE;
reg [3:0]NS=IDLE;
reg [3:0]cnt=0;
reg [15:0]clkcnt=0;
always @(posedge clk or negedge rst_n)begin
    if(!rst_n) clkcnt<=0;
    else begin
        if(NS!=IDLE)begin
            if(clkcnt<CLKS_PER_BIT) clkcnt<=clkcnt+1;
            else clkcnt<=0;
        end
        else clkcnt<=0;
    end
end
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        CS<=IDLE;
    end
    else CS<=NS;
end
always @(*)begin
    NS=CS;
    if(startswitch==0) NS=IDLE;
    else begin
        case(CS)
            IDLE:NS=START;
            START:begin
                if(clkcnt==CLKS_PER_BIT) NS=DATA;
                else NS=START;
            end
            DATA:begin
                if(cnt==8 && clkcnt==CLKS_PER_BIT) NS=STOP;
                else NS=DATA;
            end
            STOP:begin
                if(clkcnt==CLKS_PER_BIT) NS=START;
                else NS=STOP;
            end
            default:NS=IDLE;
        endcase
    end
end
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
    numstored<=0;
    end
    else begin
        case(NS)
            IDLE:numstored<=0;
            START:begin
                if(CS==STOP || CS==IDLE)numstored<=num;
                else numstored<=numstored;
            end
            DATA:numstored<=numstored;
            STOP:numstored<=numstored;
            default:numstored<=0;
        endcase
    end
end
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        out<=1;
        cnt<=0;
    end
    else begin
        case(NS)
            IDLE:begin
                out<=1;
                cnt<=0;
            end
            START:begin
                out<=0;
                cnt<=0;
            end
            DATA:begin
                if(cnt<=5) out<=numstored[cnt];
                else out<=0;
                if(clkcnt==CLKS_PER_BIT-1) cnt<=cnt+1;
                else cnt<=cnt;
            end
            STOP:begin
                out<=1;
                cnt<=0;
            end
            default:begin
                out<=1;
                cnt<=0;
            end
        endcase
    end
end
endmodule