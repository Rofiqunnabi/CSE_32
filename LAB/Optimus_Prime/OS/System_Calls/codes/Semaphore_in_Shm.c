// Create a shared memory segment so that a binary semaphore can be stored.
// 16.9.2021

#include <sys/shm.h>
#include <stdio.h>
#include <semaphore.h>


int allocate_shared_memory(char *path){
	key_t key;
	int shmID; 
	
	key = ftok(path, 'a');
	shmID = shmget(key, 1024, IPC_CREAT | 0666); // Allocate a SystemV shared memory segment
	printf("SharedMemory ID: %d\n", shmID);
	
	return shmID;
}

void get_semaphore_value(sem_t *sem){
	int sem_value;
	
	sem_getvalue(sem, &sem_value);
	printf("Value of Semaphore: %d\n", sem_value);
}

int main(){
	int shmID_semaphore;
	sem_t sem;
	
	// Allocate a shared memory segment for semaphore.
	shmID_semaphore = allocate_shared_memory("/home/cse/OperatingSystem/Code/Semaphore_Processes.c");
	
	// Attach shared memory segment to the process to keep semaphore value.
	sem_t *semPtr = shmat(shmID_semaphore, NULL, 0); 
	
	// Initialize a binary semaphore.
	sem_init(sem_ptr, 1, 1);
	get_semaphore_value(semPtr);
	
	// Decrement semaphore before entering into the critical section.
	sem_wait(sem_ptr);
	get_semaphore_value(semPtr);
	
	/* Critical section */
	
	// Increment semaphore after exiting from the critical section.
	sem_post(sem_ptr);
	get_semaphore_value(semPtr);
	
	
	return 0;
}
