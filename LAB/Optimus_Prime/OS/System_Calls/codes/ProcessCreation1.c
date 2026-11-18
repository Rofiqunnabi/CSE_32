// 5.8.2021

#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>

int main(){
	fork(); // Create a child process. Return value: -Negative_Value / 0 / CHILD_PID

	printf("Hello\n");
	
	return 0;
}
