module debounce
#(
    parameter IDLE=4'b0001,
    parameter PRESS=4'b0010,
    parameter STABLE=4'b0100,
    parameter RELEASE=4'b1000,
    parameter SAMPLE=1000000
)
(
    input rst_n,
    input clk,
    input key,
    output reg out
);
reg [19:0]cnt=0;
reg sample;
reg op=0;
reg lastop=0;
reg [3:0]CS;
reg [3:0]NS;
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt<=0;
        sample<=0;
    end
    else begin
        sample<=0;
        if(cnt===SAMPLE)begin
            sample<=1;
            cnt<=0;
        end
        else cnt<=cnt+1;
    end
end
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        op<=0;
        lastop<=0;
    end
    else if(sample===1)begin
        lastop<=op;
        op<=key;
    end
end
always @(posedge clk or negedge rst_n)begin
    if(!reset) CS<=IDLE;
    else CS<=NS;
end
always @(*)begin
    NS=CS;
    case(CS)
        IDLE:begin
            if(lastop===0 && op===1) NS=PRESS;
        end
        PRESS:begin
            if(lastop===1 && op===1) NS=STABLE;
            else if(lastop===1 && op===0) NS=IDLE;
        end
        STABLE:begin
            if(lastop===1 && op===0) NS=RELEASE;
        end
        RELEASE:begin
            if(lastop===1 && op===1) NS=STABLE;
            if(lastop===1 && op===0) NS=RELEASE;
            if(lastop===0 && op===1) NS=RELEASE;
            if(lastop===0 && op===0) NS=IDLE;
        end
        default:begin
            NS=IDLE;
        end
    endcase
end
always @(posedge clk or negedge rst_n)begin
    if(!rst_n) out<=0;
    else if(NS===IDLE && CS===RELEASE) out<=1;
    else out<=0;
end
endmodule