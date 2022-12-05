#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#define BUFSIZE 84
#define LINESIZE 28

//MemTotal:       16233788 kB
//MemFree:         6667884 kB
//MemAvailable:   10139944 kB
int main()	{
	char buf[BUFSIZE];
	int fd = open("/proc/meminfo", O_RDONLY);
	if (fd < 0)	{
		printf("Error: couldn't open file\n");
		return 1;
	}
	if (read(fd, &buf, BUFSIZE) < 0)	{
		printf("Error: couldn't read file\n");
		return 2;
	}
	int total = atoi(buf + 9) / 1000000;
	int free = atoi(buf + LINESIZE + 10) / 1000000;
	int quart = total / 4;
	char *ico = "\xef\x94\xb8";
	char *col = "#FF0000";
	if (free < total / 4)
		col = "#00FF00";
	else if (free < (total - quart))
		col = "#FFFF00";
	printf("<span color=\"%s\"><span font=\"Font Awesome 6 Free\">%s</span>: %dGB/%dGB</span>", col, ico, free, total);
}
