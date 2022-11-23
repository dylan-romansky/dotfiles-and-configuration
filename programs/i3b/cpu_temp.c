#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>

//This program will plug straight into my i3blocks config
//So that I can keep track of how hot my computer is getting

int main()	{
	char buf[7];
	int fd = open("/sys/class/thermal/thermal_zone0/temp", O_RDONLY);
	if (fd < 0)	{
		printf("Error: file not found\n");
		return 1;
	}
	if (read(fd, &buf, 6) < 0)	{
		printf("Error: could not read file\n");
		return 2;
	}
	buf[6] = 0;
	int temp = atoi(buf) / 1000;
	char* col = "#FF0000";
	char* ico = "\xef\x81\xad";
	if (temp < 50)	{
		col = "#00FF00";
		ico = "\xef\x9d\xab";
	}
	else if (temp < 80)	{
		col = "#FFFF00";
		ico = "\xef\x9d\xa9";
	}
	printf("<span color=\"%s\"><span font=\"Font Awesome 6 Free\">%s</span: %iC</span>", col, ico, temp);
}
