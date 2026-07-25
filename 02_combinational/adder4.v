module adder4(
	input wire [3:0] a,
	input wire [3:0] b,
	input wire cin,
	output wire [3:0] sum,
	output wire cout
);
wire cout0;
wire cout1;
wire cout2;
fulladder fa0(
	.a(a[0]),
	.b(b[0]),
	.cin(cin),
	.sum(sum[0]),
	.cout(cout0)
);
fulladder fa1(
	.a(a[1]),
	.b(b[1]),
	.cin(cout0),
	.sum(sum[1]),
	.cout(cout1)
);
fulladder fa2(
	.a(a[2]),
	.b(b[2]),
	.cin(cout1),
	.sum(sum[2]),
	.cout(cout2)
);
fulladder fa3(
	.a(a[3]),
	.b(b[3]),
	.cin(cout2),
	.sum(sum[3]),
	.cout(cout)
);
endmodule
