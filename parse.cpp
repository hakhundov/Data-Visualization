#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <vector>
#include <string>

#define BUFLEN 255
#define PLEN 32

#define MAP_W 256
#define MAP_H 256

typedef unsigned int uint;
typedef unsigned int uchar;


#define TEAM_DIRE		0
#define TEAM_RADIANT	1

typedef struct entry_t_ {
	uint matchid;
	uint tsync;
	uint x;
	uint y;
	char team;
	char player[PLEN];
} entry_t;


void read_line(char *string, uint len, entry_t *entry);
void write_csv(std::vector<entry_t> &vec, FILE *out, uint matchid);

int main (int argc, char **argv) {
	FILE *input, *output;
	char buf[BUFLEN+1];

	uint matchid = 0;
	uint i;
	entry_t entrybuf;
	std::vector<entry_t> entries;

	if (argc < 2) {
		printf("Missing filename\n");
		return 1;
	}
	if (argc == 3) {
		sscanf(argv[1], "%u", &matchid);
	}
	
	input = fopen(argv[argc-1], "r");
	if (input == NULL) {
		printf("Cannot open file!\n");
		return 2;
	}
	if(fgets(buf, BUFLEN, input) == NULL) {
		printf("Invalid file\n");
		return 3;
	}

	while(fgets(buf, BUFLEN, input) != NULL) {
		read_line(buf, BUFLEN, &entrybuf);
		entries.push_back(entrybuf);
	}
	printf("Read %u entries\n", entries.size());

	if (matchid != 0) {
		char nbuf[32];
		sprintf(nbuf, "match_%u.csv", matchid);
		output = fopen(nbuf, "w");
		if (output == NULL) {
			printf("Cannot open output file!\n");
			return 5;
		}
		write_csv(entries, output, matchid);
		printf("Match written to %s\n", nbuf);
	}

	return 0;
}

void read_line(char *string, uint len, entry_t *entry) {
	char *p;
	sscanf(string, "%u,%u,%u,%u", &entry->tsync, &entry->x, &entry->y, &entry->matchid);
	p = strtok(string, ",\n");
	while (p[0] != '\"') {
		p = strtok(NULL, ",\n");
	}
	if (strcmp(p, "\"radiant\"") == 0) {
		entry->team = TEAM_RADIANT;
	} else {
		entry->team = TEAM_DIRE;
	}
	p = strtok(NULL, ",\n");
    strncpy(entry->player, p, PLEN);
	p = strtok(NULL, ",\n");//won
	p = strtok(NULL, ",\n");//stdtime
	p = strtok(NULL, ",\n");//synctime
	sscanf(p, "%u", &entry->tsync);
}

void write_csv(std::vector<entry_t> &vec, FILE *out, uint matchid) {
	uint i;
	fprintf(out, "t,x,y,team,player\n");
	for (i = 0; i < vec.size(); ++i) {
		if (matchid == 0 || matchid == vec[i].matchid) {
			fprintf(out, "%u,%u,%u,%c,%s\n", vec[i].tsync, vec[i].x, vec[i].y, vec[i].team, vec[i].player);
		}
	}
}