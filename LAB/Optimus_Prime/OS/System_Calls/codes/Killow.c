#include<stdio.h>
#include<unistd.h>

int main(){

	pid_t pid;
	
	for(int i=0; i<1; i--){
		pid = getpid();
		printf("I'm child - %u\n", pid);
	}
	
	return 0;
}
