// To check whether different core is assigned to a process or thread at different time.
// Two processes (parent process + child process) having 2 threads (1 main thread + 1 sub thread) will run.
// --------------------------------------------------------
// $ gcc Core_Checking_v1.c -o Core_Checking_v1 -pthread
// $ ./Core_Checking_v1
// --------------------------------------------------------
// 10.10.2021

#define _GNU_SOURCE
#include <unistd.h>
#include <sched.h>
#include <stdio.h>
#include <wait.h>
#include <pthread.h>

void tasks(char *processInfo, char *threadInfo){
	int coreNo, i;
	
	for (i = 1; i < 100; i++){
		coreNo = sched_getcpu();
		printf("%d. %s Process --> %s Thread: %d\n", i, processInfo, threadInfo, coreNo);
	}
}

void *sub_thread(char *processInfo){
	tasks(processInfo, "Sub");
}

void thread_handler(char *processInfo){
	pthread_t TID;
		
	pthread_create(&TID, NULL, (void *) sub_thread, processInfo);
	pthread_join(TID, NULL);
}

int main(){
	pid_t childPID;
	
	childPID = fork();
	if (childPID == 0){ // Child process
		tasks("Child", "Main");
		thread_handler("Child");
	}
	else if (childPID > 0){ // Parent process
		tasks("Parent", "Main");
		thread_handler("Parent");
		wait(NULL);
	}
	
	return 0;
}
