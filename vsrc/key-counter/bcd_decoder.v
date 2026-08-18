module bcd_decoder(
    input clk,
    input [5:0]num,
    output reg [6:0]ones,
    output reg [6:0]tens,
    output reg point
);
reg [3:0]onecnt=0;
reg [3:0]tencnt=0;
reg pointcnt=0;
always @(*)begin
    onecnt=0;
    tencnt=0;
    pointcnt=0;
    if(num<10)begin
        onecnt=num;
        tencnt=0;
    end
    else if(num>=10 && num<20)begin
        onecnt=num-10;
        tencnt=1;
    end
    else if(num>=20 && num<30)begin
        onecnt=num-20;
        tencnt=2;
    end
    else if(num>=30 && num<40)begin
        onecnt=num-30;
        tencnt=3;
    end
    else if(num>=40 && num<50)begin
        onecnt=num-40;
        tencnt=4;
    end
    else if(num>=50 && num<60)begin
        onecnt=num-50;
        tencnt=5;
    end
    else if(num==60)begin
        onecnt=0;
        tencnt=6;
    end
    else begin
        onecnt=0;
        tencnt=0;
        pointcnt=1;
    end
end
always @(posedge clk)begin
    case(onecnt)
        0:ones<=7'b1111110;//按照{a,b,c,d,e,f,g}的顺序来
        1:ones<=7'b0110000;
        2:ones<=7'b1101101;
        3:ones<=7'b1111001;
        4:ones<=7'b0110011;
        5:ones<=7'b1011011;
        6:ones<=7'b1011111;
        7:ones<=7'b1110000;
        8:ones<=7'b1111111;
        9:ones<=7'b1111011;
        default:ones<=7'b0000000;
    endcase
    case(tencnt)
        0:tens<=7'b1111110;
        1:tens<=7'b0110000;
        2:tens<=7'b1101101;
        3:tens<=7'b1111001;
        4:tens<=7'b0110011;
        5:tens<=7'b1011011;
        6:tens<=7'b1011111;
        default:tens<=7'b0000000;
    endcase
    point<=pointcnt;
end
endmodule