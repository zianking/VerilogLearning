#include<Vencoder8to3.h>
#include<verilated.h>

#include<stdio.h>

int test(Vencoder8to3 *top,int D){
	int x=0;
	top->D=D;
	top->eval();
	int cnt=0;
	while(D){
		D=D/2;
		cnt++;
	}
	if(cnt>0) x=((cnt-1)==top->Y && top->valid==1)?0:1;
	else x=(top->valid)?1:0;
	if(x) printf("FAIL: ");
	else printf("PASS: ");
	int expect_valid=0;
	if(cnt>=0) expect_valid=1;
	printf("D=%d ->Y=%d expect_Y=%d valid=%d expect_valid=%d\n",top->D,top->Y,(cnt-1),top->valid,expect_valid);
	return x;
}

int main(int argc,char **argv){
	VerilatedContext *contextp=new VerilatedContext;
	Vencoder8to3 *top=new Vencoder8to3;
	int cnt=0;
	for(int i=0;i<256;i++){
		if(test(top,i)) cnt++;
	}
	printf("%d Error\n",cnt);
	delete top;
	delete contextp;
	return 0;
}
