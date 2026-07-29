//this encoder is a priority one
module encoder4to2(input wire [3:0]D,output wire [1:0]Y,output wire valid);
assign Y[1]=D[3]|D[2];
assign Y[0]=D[3]|((!D[2])&D[1]);
assign valid=D[3]|D[2]|D[1]|D[0];
endmodule;
