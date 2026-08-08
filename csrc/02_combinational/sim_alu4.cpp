#include "Valu4.h"
#include "verilated.h"
#include<stdio.h>
int test(Valu4 *top,int A,int B,int op,int expect_Y){
	int x=0;
	top->A=A;
	top->B=B;
	top->op=op;
	top->eval();
	if(top->Y==expect_Y) printf("PASS: ");
	else{
		printf("FAIL: ");
		x=1;
	}
	printf("A=%d B=%d op=%d -> Y=%d expect_Y=%d\n",top->A,top->B,top->op,top->Y,expect_Y);
	return x;
}

int main(int argc,char **argv){
	VerilatedContext *contextp=new VerilatedContext;
	Valu4 *top=new Valu4{contextp};
	int error=0;
	for(int A=0;A<16;A++)
		for(int B=0;B<16;B++)
			for(int op=0;op<8;op++){
				int expect_Y=0;
				switch(op){
					case 0:
						expect_Y=(A+B)%16;break;
					case 1:
						expect_Y=(A-B<0)?(A-B+16):(A-B);break;
					case 2:
						expect_Y=A&B;break;
					case 3:
						expect_Y=A|B;break;
					case 4:
						expect_Y=A^B;break;
					case 5:
						expect_Y=(A<<1)%16;break;
					case 6:
						expect_Y=A>>1;break;
					default:
						expect_Y=0;break;
				}
				if(test(top,A,B,op,expect_Y)) error++;
			}
	printf("%d ERROR\n",error);
	delete top;
	delete contextp;
	return 0;
}
