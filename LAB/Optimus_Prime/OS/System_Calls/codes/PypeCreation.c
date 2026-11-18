
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
	char *pipePath;
	int pipeFlag, fd;

	for(int i = 1; i < argc; i++) {
		pipePath = argv[i];
		if(access(pipePath, F_OK) == 0) { // Pipe exists
			printf("%s is already created, so new pipe will not be created\n. ", pipePath);
		} else {// Pipe does not exists, so we can create a new pipe.
			pipeFlag = mkfifo(pipePath, 0666); // mkfifo(pipePath, permission)
			if (pipeFlag < 0){
				printf("Error in creating a named pipe.\n");
				exit(-1);	
			} else{
				printf("%s Pipe has been created successfully.\n", pipePath);
			}
		}
	}
	
	return 0;
}