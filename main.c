#include <stdio.h>
#include <string.h>
#include "parens.tab.h"
#include "parens.lex.h"

extern int yylex();
extern int yyparse();

void print_usage() {
    printf(
        "This is Dyck language parser.\n"
        "Invoke this program with the file you want "
        "to check as its first argument.\n");
}

int main(int argc, char** argv) {
    if (argc < 2) {
        print_usage();
        return 1;
    }
    if (argc == 2) {
        yyin = fopen(argv[1], "r");
        if (errno != 0) {
            fprintf(stderr, "Couldn't open: %s\n", argv[1]);
            return errno;
        }
        return yyparse();
    }
    fprintf(stderr, "Wrong number of arguments\n");
    print_usage();
    return 1;
}
