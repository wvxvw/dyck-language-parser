%{
#include <string.h>
#include "parens.tab.h"
%}

%%

[(]                      { return OPEN_PAREN; }
[)]                      { return CLOSE_PAREN; }
[{]                      { return OPEN_CURLY; }
[}]                      { return CLOSE_CURLY; }
[[]                      { return OPEN_BRACKET; }
[\]]                     { return CLOSE_BRACKET; }
[<]                      { return LESS_THAN; }
[>]                      { return GREATER_THAN; }
[^(){}[\]<>]+            { return SKIP; }

%%

int yywrap() { return 1; }
