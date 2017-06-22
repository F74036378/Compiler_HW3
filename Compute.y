%{
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
extern int yylineno;
extern int yylex();
void yyerror(char *);

FILE *file;
int indexa = -1;
int index_max = 9;

typedef struct arr{
	int value;
	char *id;
} node;

node *sym;

void create_sym();
int insert_sym(char *);
int check_sym(char*);
int getval_sym(int);
void ass_sym(int, int);
void dump_sym();
char* id_split(char*);

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
					
				}
    | lines Stmt '\r' '\n'     {
                    
                    fprintf(file,   "getstatic java/lang/System/out Ljava/io/PrintStream;\n"
                            "swap       ;swap the top two items on the stack \n"
                            "invokevirtual java/io/PrintStream/println(I)V\n" );
                }
     ;

Stmt: Decl SEM {printf("decl\n");}
    | Print SEM {printf("print\n");}
    | Ari  SEM {printf("ari\n");}
    |
    ;

Decl: INTNUM ID                  {
					char *sid = id_split($2);
					if(indexa != -1){
						if(check_sym(sid) == -1){
							insert_sym(sid);
						}
						else{yyerror("has declaed\n");}
					}
					else{
						create_sym();
						insert_sym(sid);
					}
				 }
    | INTNUM ID '=' expression   {
					char *sid =id_split($2);
					printf("%s\n",sid);
					printf("int id ass\n");
					if(indexa != -1){
						if(check_sym(sid) == -1){
							int pp = insert_sym(sid);
							ass_sym(pp, $4);
							fprintf(file, "istore %d \n", pp);
						}
						else{yyerror("has declaed\n");}
					}
					else{
						create_sym();
						int pp = insert_sym(sid);
						printf("%s\n",sym[0].id);
						ass_sym(pp, $4);
						fprintf(file, "istore %d \n",pp);
					}
					
				 }
    ;

Print: PRI group   {	printf("print gup\n");
			fprintf(file, "ldc %d \n",$2);
			fprintf(file,	"getstatic java/lang/System/out Ljava/io/PrintStream;\n"
				"swap		;swap the top two items on the stack \n"
				"invokevirtual java/io/PrintStream/println(I)V\n" );
			}
     | PRI '(' STR ')'   {		
					char *st = $3;
					st[strlen(st)-1] = '\n';
					printf("print %s\n",st);
					fprintf(file,"ldc %s \n",st);
					fprintf(file,	"getstatic java/lang/System/out Ljava/io/PrintStream;\n"
							"swap		;swap the top two items on the stack \n"
							"invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V\n" );
			}
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
    | ID      {
			char *sid = id_split($1);
			int pp = check_sym(sid);
			if(pp == -1){yyerror("not declared\n");}
			else{
				fprintf(file,"iload %d\n", pp);
				$$ = getval_sym(pp);
			}
	      }
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
	dump_sym();
	printf("Generated: %s\n","Computer.j");

    	return 0;
}


void yyerror(char *s) {
    printf("%s on %d line \n", s , yylineno);
}

void create_sym(){
    printf("Create Symbol Table\n");
    sym = malloc(sizeof(node)*10);
    indexa = 0;
}

int insert_sym(char *id){
	int i,n = 0;
	for(i=0;i<indexa;i++){
		if(!strcmp(sym[i].id, id)){
			n = 1;
			return -1;
		}
	}
	if(n != 1){
		sym[indexa].id = id;
		if(indexa == index_max){
			sym = realloc(sym, (index_max+11)*sizeof(node));
			index_max += 10;
		}
		indexa++;
	}
	return indexa-1;
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

void ass_sym(int locate, int val){
	sym[locate].value = val;
}

void dump_sym(){
	int i;
	printf("Symbol Table\n");
	for(i=0;i<indexa;i++){
		printf("%d %s %d\n", i, sym[i].id, sym[i].value);
	}
}

char* id_split(char *id){
	char deli[] = " \t\n\r\v\f";
	return strtok(id, deli);
}
