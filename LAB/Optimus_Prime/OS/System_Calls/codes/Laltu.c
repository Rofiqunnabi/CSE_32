#define _GNU_SOURCE
#include <sys/ipc.h>
#include <stdio.h>
#include <sys/shm.h>
#include <string.h>
#include <sched.h>
#include <unistd.h>
#include <stdlib.h>
#include <semaphore.h>
#include <sys/wait.h>
#include<fcntl.h>

char *converter(int n){
    char *str;
    str = malloc(10*sizeof(char));
    sprintf(str,"%d",n);
    return (char *)str;
}

int create_shared_memory(char *path){
	key_t key;
	int shmID;
	key = ftok(path, 'a');
	shmID = shmget(key, 1024, IPC_CREAT | 0666);

	return shmID;
}
void write_to_shm(int x, int shmID){ 	
	int *str = shmat(shmID, NULL, 0);
    *str = x;
	shmdt(str);
}

int read_from_shm(int shmID){ 
	
	int *str = shmat(shmID, NULL, 0);
	int num = *str;
	shmdt(str);
	return num;
}

void child_error_check(pid_t childPID){
    if(childPID < 0){
        printf("Error  while creating child process!!!");
        exit(-1);
    }
}



int main(){
	int shmID_result;
	sem_t *semPtr;
	pid_t childPID1,childPID2,childPID3;
	int a, b,res;

    printf("Enter two numbers: \n");
    scanf("%d %d",&a,&b);

    char *no1 =  converter(a);
    char *no2 =  converter(b);

    shmID_result = create_shared_memory("Mittu.c");
    semPtr = sem_open("/mysem", O_CREAT, 0666, 1);
   
    int result = 0;
    write_to_shm(result,shmID_result);
    res = read_from_shm(shmID_result);
    printf("Initially Result :%d\n",res);
    
	
	childPID1 = fork();
	child_error_check(childPID1);

	if (childPID1 == 0){ // 1st Child Process	
        execlp("./Ittu",no1,no2,NULL);
	}
	else{
		// Create child processes.
		childPID2 = fork();
        child_error_check(childPID2);
 
		if(childPID2 == 0){ // 2nd Child process

            execlp("./Bittu",no1,no2,NULL);
			
		}
		else {
            childPID3= fork();
            child_error_check(childPID3);

		    if(childPID3 == 0){ // 3rd Child process

                execlp("./Mittu",no1,no2,NULL);
			
		    }

            else{

                sem_wait(semPtr);
                result = read_from_shm(shmID_result);
                printf("A: %d B: %d Result: %d in Laltu [PID: %d Core: %d] Parent\n\n",a,b,result,getpid(),sched_getcpu());
                sem_post(semPtr);

                // Wait until the child process finishes its task.
                waitpid(childPID1,NULL,0);
                waitpid(childPID2,NULL,0);
                waitpid(childPID3,NULL,0);
            }
		}
	}
	
	shmdt(semPtr);//detaching shared memory of semaphore
	return 0;
}