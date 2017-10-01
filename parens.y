%{
#include <stdio.h>

extern int yylineno;

void yyerror(char const *s) {
    fprintf(stderr, "%d: %s\n", yylineno, s);
}

int yylex();
%}

%start s;
%token OPEN_PAREN;
%token CLOSE_PAREN;
%token OPEN_CURLY;
%token CLOSE_CURLY;
%token OPEN_BRACKET;
%token CLOSE_BRACKET;
%token GREATER_THAN;
%token LESS_THAN;
%token SKIP;

%%
parens  : OPEN_PAREN s CLOSE_PAREN
        | OPEN_PAREN CLOSE_PAREN
        ;
brakets : OPEN_BRACKET s CLOSE_BRACKET
        | OPEN_BRACKET CLOSE_BRACKET
        ;
curlies : OPEN_CURLY s CLOSE_CURLY
        | OPEN_CURLY CLOSE_CURLY
        ;
ltgt    : LESS_THAN s GREATER_THAN
        | LESS_THAN GREATER_THAN
        ;
exp     : parens
        | brakets
        | curlies
        | ltgt
        ;
exps    : exp SKIP
        | exp
        ;
s       : SKIP
        | exps
        | s exps
        ;

%%
