#include "Vmux.h"
#include "verilated.h"
#include<stdio.h>

int main(int argc,char **argv){//argc表示传入的参数数量，argv表示一个字符串数组，其中元素就是按顺序传入的参数
	Verilated::commandArgs(argc,argv);

	Vmux *mux=new Vmux;//new是C++写法，相当于C中的malloc
	for(mux->sel=0;mux->sel<=1;mux->sel++){
		for(mux->a=0;mux->a<=1;mux->a++){
			for(mux->b=0;mux->b<=1;mux->b++){
				mux->eval();//调用class Vmux里的eval()函数，函数返回类型是void
				printf("a=%d b=%d sel=%d y=%d\n",mux->a,mux->b,mux->sel,mux->y);
			}
		}
	}
	delete mux;//delete是C++写法，相当于C中的free
	return 0;
}
