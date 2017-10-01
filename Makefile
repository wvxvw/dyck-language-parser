CC := gcc
YACC := yacc
LEX := lex
SOURCES := $(wildcard ./*.c)
YACC_SOURCES := $(wildcard ./*.y)
LEX_SOURCES := $(wildcard ./*.l)
OBJECTS := $(SOURCES:.c=.o)
YACC_GENERATED := $(YACC_SOURCES:.y=.tab.c)
LEX_GENERATED := $(LEX_SOURCES:.l=.lex.c)
CFLAGS := -fno-diagnostics-color -Wall -Wno-unused-function -fPIC -ggdb -I.
PROGRAM := parens

default: program

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.tab.c: %.y
	$(YACC) -vd $< -o $@
	$(CC) $(CFLAGS) -c $@ -o $(@:.c=.o)

%.lex.c: %.l
	$(LEX) -l --header-file=$(@:.c=.h) -o $@ $<
	$(CC) $(CFLAGS) -c $@ -o $(@:.c=.o)

program: $(YACC_GENERATED) $(LEX_GENERATED) $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) $(YACC_GENERATED:.c=.o) \
		$(LEX_GENERATED:.c=.o) -o $(PROGRAM)

clean:
	-rm -f $(OBJECTS)
	-rm -f $(PROGRAM)
	-rm -f *.tab.*
	-rm -f *.lex.*

check-syntax:
	$(CC) -o nul -S $(SOURCES)
