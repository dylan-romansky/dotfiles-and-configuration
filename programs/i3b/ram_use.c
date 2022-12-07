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
	int total = atoi(buf + 9);
	int used = total - atoi(buf + LINESIZE*2 + 14);
	int quart = total / 4;
	char *ico = "\xef\x94\xb8";
	char *col = "#FF0000";
	if (used < total / 4)
		col = "#00FF00";
	else if (used < (total - quart))
		col = "#FFFF00";
	printf("<span color=\"%s\"><span font=\"Font Awesome 6 Free\">%s</span>: %dGB/%dGB</span>", col, ico, used / 1000000, total / 1000000);
}
