module shifter4(input wire [3:0]A,input wire shift,input wire direction,output wire [3:0]Y);
wire [3:0]m;
mux2(.a(A[2]),.b(0),.sel(direction),.y(m[3]));
mux2(.a(A[1]),.b(A[3]),.sel(direction),.y(m[2]));
mux2(.a(A[0]),.b(A[2]),.sel(direction),.y(m[1]));
mux2(.a(0),.b(A[1]),.sel(direction),.y(m[0]));
assign Y=shift?m:A;
endmodule;
