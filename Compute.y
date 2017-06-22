%{
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
extern int yylineno;
extern int yylex();
void yyerror(char *);

FILE *file;
int indexa = 0;
int index_max = 9;

typedef struct arr{
	int value;
	char *id;
} node;

node *sym;

void create_sym();
void insert_sym(char *, int);
int check_sym(char*);
int getval_sym(int);
void dump_sym();

%}

%union {
	int intVal;
	char *ids;
}

%token NUMBER SEM STR ID INTNUM PRI

%type <intVal> factor group term expression NUMBER INTNUM
%type <ids> ID STR



%%
lines
    :
    | lines Stmt '\n'  	{
					
					fprintf(file,	"getstatic java/lang/System/out Ljava/io/PrintStream;\n"
							"swap		;swap the top two items on the stack \n"
							"invokevirtual java/io/PrintStream/println(I)V\n" );
				}
    | lines Stmt '\r' '\n'     {
                    
                    fprintf(file,   "getstatic java/lang/System/out Ljava/io/PrintStream;\n"
                            "swap       ;swap the top two items on the stack \n"
                            "invokevirtual java/io/PrintStream/println(I)V\n" );
                }
     ;

Stmt: Decl ';' {printf("decl\n");}
    | Print ';' {printf("print\n");}
    | Ari  ';' {printf("ari\n");}
    |
    ;

Decl: INTNUM ID {printf("int id\n");}
    | INTNUM ID '=' expression   {printf("int id ass\n");}
    ;

Print: PRI group   {printf("print gup\n");}
     | PRI '(' STR ')'   {printf("print Str\n");}

Ari: ID '=' expression   {printf("ass ari\n");}

expression
    : term   { $$ = $1; }
    | expression '+' term {printf("Add  \n"); $$ = $1 + $3; fprintf(file,"iadd \n");}
    | expression '-' term {printf("Sub  \n"); $$ = $1 - $3; fprintf(file,"isub \n");}
    ;

term
    : factor   { $$ = $1; }
    | term '*' factor  {printf("Mul  \n"); $$ = $1 * $3; fprintf(file,"imul \n");}
    | term '/' factor  {printf("Div  \n"); $$ = $1 / $3; fprintf(file,"idiv \n");}
    ;

factor
    : NUMBER   { $$ = $1; fprintf(file,"ldc %d\n" , $1);}
    | ID      {printf("%s\n",$1);fprintf(file,"iload %s\n", $1);}
    | group   { $$ = $1; fprintf(file,"ldc %d\n" , $1);}
    ;

group
    : '(' expression ')' { $$ = $2; }
    ;

%%
int main(int argc, char** argv)
{

	file = fopen("Computer.j","w");
	
	fprintf(file,	".class public main\n"
		     	".super java/lang/Object\n"
			".method public static main([Ljava/lang/String;)V\n"
			"	.limit stack %d\n"
			"	.limit locals %d\n",10,10);

    	yyparse();


	fprintf(file,	"return\n"
		     	".end method\n");
	
	fclose(file);
	printf("Generated: %s\n","Computer.j");

    	return 0;
}


void yyerror(char *s) {
    printf("%s on %d line \n", s , yylineno);
}

void create_sym(){
    sym = malloc(sizeof(node)*10);	
}

void insert_sym(char *id, int val){
	int i,n = 0;
	for(i=0;i<indexa;i++){
		if(!strcmp(sym[i].id, id)){
			sym[i].value = val;
			n = 1;
			break;
		}
	}
	if(n != 1){
		sym[indexa].id = id;
		sym[indexa].value = val;
		if(indexa == index_max){
			sym = realloc(sym, (index_max+11)*sizeof(node));
			index_max += 10;
		}
		indexa++;
	}
}

int check_sym(char *id){
	int i;
	for(i=0;i<indexa;i++){
		if(!strcmp(sym[i].id, id)){
			return i;
		}
	}
	return -1;
}

int getval_sym(int num){
	return sym[num].value;
}

void dump_sym(){}
