// 17.8.2021
// To read from a named pipe.

#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>

int main(int argc, char *argv[]){
	
	char buffer[200];

	while(1)
	{
		int fd, xd;
		char *pipePath;

		pipePath = argv[1];

		fd = open(pipePath, O_RDWR);	

		read(fd, buffer, sizeof(buffer));


		
	 	//printf("%d", buffer[step]);
		// Display to the monitor.
		write(STDOUT_FILENO, buffer, strlen(buffer));
		printf("\n");
		if(strcmp(buffer,"bye") == 0) {
			write(fd, "bye", strlen("bye") + 1);
			return 0;
		}
		close(fd);


		

	}

	return 0;
}