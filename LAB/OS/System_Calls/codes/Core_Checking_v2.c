// To check whether different core is assigned to a process or thread at different time.
// Two processes (parent process + child process) having 6 threads (1 main thread + 5 sub threads) will run.
// --------------------------------------------------------
// $ gcc Core_Checking_v2.c -o Core_Checking_v2 -pthread
// $ ./Core_Checking_v2
// --------------------------------------------------------
// 10.10.2021

#define _GNU_SOURCE
#include <unistd.h>
#include <sched.h>
#include <stdio.h>
#include <wait.h>
#include <pthread.h>
#include <string.h>

typedef struct thread_parameters{
	char *processInfo;
	char *threadInfo;
} thread_param;

void tasks(char *processInfo, char *threadInfo){
	int coreNo, i;
	
	for (i = 1; i < 10; i++){
		coreNo = sched_getcpu();
		printf("%d. %s Process --> %s Thread --> CPU: %d\n", i, processInfo, threadInfo, coreNo);
	}
}

void *sub_thread(thread_param *tp){
	tasks(tp->processInfo, tp->threadInfo);
}

void thread_handler(char *processInfo){
	pthread_t TID1, TID2, TID3, TID4, TID5;
	thread_param tp1, tp2, tp3, tp4, tp5;
	
	tp1.processInfo = processInfo;
	tp1.threadInfo = "Sub1";
	tp2.processInfo = processInfo;
	tp2.threadInfo = "Sub2";
	tp3.processInfo = processInfo;
	tp3.threadInfo = "Sub3";
	tp4.processInfo = processInfo;
	tp4.threadInfo = "Sub4";
	tp5.processInfo = processInfo;
	tp5.threadInfo = "Sub5";
		
	pthread_create(&TID1, NULL, (void *) sub_thread, &tp1);
	pthread_create(&TID2, NULL, (void *) sub_thread, &tp2);
	pthread_create(&TID3, NULL, (void *) sub_thread, &tp3);
	pthread_create(&TID4, NULL, (void *) sub_thread, &tp4);
	pthread_create(&TID5, NULL, (void *) sub_thread, &tp5);
	pthread_join(TID1, NULL);
	pthread_join(TID2, NULL);
	pthread_join(TID3, NULL);
	pthread_join(TID4, NULL);
	pthread_join(TID5, NULL);
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
