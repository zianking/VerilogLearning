module comparator4(input wire [3:0]A,input wire [3:0]B,output wire gt,output wire eq,output wire lt);
wire [3:0]g;
wire [3:0]e;
wire [3:0]l;
comparator1 c3(.A(A[3]),.B(B[3]),.gt(g[3]),.eq(e[3]),.lt(l[3]));
comparator1 c2(.A(A[2]),.B(B[2]),.gt(g[2]),.eq(e[2]),.lt(l[2]));
comparator1 c1(.A(A[1]),.B(B[1]),.gt(g[1]),.eq(e[1]),.lt(l[1]));
comparator1 c0(.A(A[0]),.B(B[0]),.gt(g[0]),.eq(e[0]),.lt(l[0]));
wire [1:0]y;
wire valid;
encoder4to2(.D(~e),.Y(y),.valid(valid));
assign eq=~valid;
assign gt=g[y]&valid;
assign lt=l[y]&valid;
endmodule
