// 17.8.2021
// To write to a named pipe.

#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>

int main(int argc, char *argv[])
{

	char msg[200];
	char buffer[200];
	int i = 0;
	while (1)
	{
		int fd, xd;
		char *pipePath;

		pipePath = argv[1];

		fd = open(pipePath, O_RDWR);
		if(i == 0) {
			char welcome[] = "Welcome from Minu";

			write(fd, welcome, strlen(welcome) + 1);
			i = i + 1;
			
		}

		scanf("%s", msg);
		printf("%s\n", msg);
		write(fd, msg, strlen(msg) + 1);
		

		
		//close(fd);
		if (strcmp(msg, "bye") == 0) {
			read(fd, buffer, sizeof(buffer));

			write(fd, msg, strlen(msg) + 1);
			if (strcmp(buffer, "bye") == 0)
				return 0;
		}

	}

	return 0;
}
