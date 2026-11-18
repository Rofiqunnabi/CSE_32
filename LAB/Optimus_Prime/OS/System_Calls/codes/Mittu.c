#define _GNU_SOURCE
#include <sys/ipc.h>
#include<stdio.h>
#include <sys/shm.h>
#include <sched.h>
#include<unistd.h>
#include<stdlib.h>
#include<string.h>
#include <semaphore.h>
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
	key = ftok(path, 'a');//1st parameter should a existing file path name
	shmID = shmget(key, 1024, IPC_CREAT | 0666);

	return shmID;
}
void write_to_shm(int x, int shmID){ 	
	int *str = shmat(shmID, NULL, 0);
    *str = *str + x;
	shmdt(str);
}

int read_from_shm(int shmID){ 
	
	int *str = shmat(shmID, NULL, 0);
	int num = *str;
	shmdt(str);
	return num;
}

int main(int argc,char *argv[]){
    sem_t *semPtr;
    int shmID_result,result,res;
    int a = atoi(argv[0]);
    int b = atoi(argv[1]);
    shmID_result = create_shared_memory("Mittu.c");

    semPtr = sem_open("/mysem", O_CREAT, 0666, 1);

    sem_wait(semPtr);
    result = read_from_shm(shmID_result);
    printf("A: %d B: %d Result: %d in Mittu [PID: %d Core: %d] Before Multiplication\n",a,b,result,getpid(),sched_getcpu());
    res = a * b;
    write_to_shm(res,shmID_result);
    result = read_from_shm(shmID_result);
    printf("A: %d B: %d Result: %d in Mittu [PID: %d Core: %d] After Multiplication\n\n",a,b,result,getpid(),sched_getcpu());
    sem_post(semPtr);
    shmdt(semPtr);
    
    return 0;
}