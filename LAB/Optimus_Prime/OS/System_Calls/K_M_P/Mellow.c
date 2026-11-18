#include<unistd.h>
#include<stdio.h>
#include<sys/wait.h>

int main()
{
	pid_t  pid, killow_pid, killow, pillow, pillow_pid;
	int *wstatus;
	killow = fork();
	if(killow == 0){
		killow_pid = getpid();
		//execlp("/home/shahriar/Desktop/Lab/Killow", "Killow", NULL);
		printf("killow - %u\n", killow_pid);
	}
	
	
	if(killow > 0){
		pillow = fork();
		if(pillow == 0){
			pillow_pid = getpid();
			//execlp("/home/shahriar/Desktop/Lab/Pillow", "Pillow", NULL);
		}
		else if(pillow > 0){
			pid = getpid();
			printf("Mellow Process-%u, parent of Killow-%u and Pillow-%u,\n", pid, killow_pid, pillow_pid);
			wait(wstatus);
		}
		
		
	}
	
	return 0;
}



