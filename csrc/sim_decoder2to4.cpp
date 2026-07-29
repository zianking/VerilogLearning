#include<Vdecoder2to4.h>
#include<verilated.h>

#include<stdio.h>

int test(Vdecoder2to4 *top,int A){
	int x=0;
	top->A=A;
	top->eval();
	int expect_Y=1<<A;
	if(top->Y==expect_Y){
		printf("PASS: ");
		x=0;
	}
	else{
		printf("FAIL: ");
		x=1;
	}
	printf("A=%d -> Y=%d expect_Y=%d\n",A,top->Y,expect_Y);
	return x;
}

int main(int argc,char **argv){
	VerilatedContext *contextp=new VerilatedContext;
	Vdecoder2to4 *top=new Vdecoder2to4;
	int cnt=0;
	for(int i=0;i<4;i++){
		if(test(top,i)) cnt++;
	}
	printf("%d Error\n",cnt);
	delete top;
	delete contextp;
	return 0;
}
