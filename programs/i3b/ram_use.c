#include <linux/sysinfo.h>
#include <sys/sysinfo.h>
#include <stdio.h>

int main()	{
	struct sysinfo usage;
	if (sysinfo(&usage))	{
		printf("Error: couldn't get usage stats\n");
		return 1;
	}
	char* col = "#FF0000";
	unsigned long used = (usage.totalram - usage.freeram - usage.bufferram - usage.sharedram) / 1000000000;
	unsigned long tot = usage.totalram / 1000000000;
	printf("mycalc\nfree:%llu\ntotal:%llu\n\n", used, tot);
	if (used < (tot / 4))
		col = "#00FF00";
	else if (used < (tot - (tot / 4)))
		col = "#FFFF00";
	printf("total:%llu\nfree:%llu\nshared:%llu\nbuffer:%llu\ntothigh:%llu\nfreehigh:%llu\n", usage.totalram, usage.freeram, usage.sharedram, usage.bufferram, usage.totalhigh, usage.freehigh);
	for (int i = 0; i < 3; i++)
		printf("load %i: %llu\n", i, usage.loads[i]);
	//printf("<span color=\"%s\"><span font=\"Font Awesome 6 Free\">\xef\x04\xb8</span: %lluGB/%lluGB</span>", col, used, tot);
}
