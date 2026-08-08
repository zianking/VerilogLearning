module comparator1(input wire A,input wire B,output wire gt,output wire eq,output wire lt);
assign gt=A&(!B);
assign eq=!(A^B);
assign lt=(!A)&B;
endmodule;
