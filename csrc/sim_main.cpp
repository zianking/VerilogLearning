#include "Vadder4.h"
#include "verilated.h"

#include<stdio.h>

int test(Vadder4 *top,int a,int b,int cin,int expect_sum,int expect_cout){
	int x=0;
	top->a=a;
	top->b=b;
	top->cin=cin;
	top->eval();
	if(top->sum==expect_sum && top->cout==expect_cout){
		printf("PASS:");
	}
	else{
		printf("FAIL:");
		x=1;
	}
	printf("a=%d b=%d cin=%d -> sum=%d cout=%d\n",a,b,cin,top->sum,top->cout);
	return x;
}

int main(int argc,char **argv){
	VerilatedContext *contextp=new VerilatedContext;
	Vadder4 *top=new Vadder4{contextp};
	int error=0;
	for(int cin=0;cin<=1;cin++){
		for(int a=0;a<=15;a++){
			for(int b=0;b<=15;b++){
				int expect_sum=0;
				int expect_cout=0;
				if(a+b+cin<=15){
					expect_sum=a+b+cin;
					expect_cout=0;
				}
				else{
					expect_sum=a+b+cin-16;
					expect_cout=1;
				}
				if(test(top,a,b,cin,expect_sum,expect_cout)) error++;
			}
		}
	}
	printf("%d ERROR\n",error);
	delete top;
	delete contextp;
	return 0;
}
