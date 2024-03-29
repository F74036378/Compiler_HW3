%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "y.tab.h"	/* header file generated by bison */
extern int yylineno;
%}

letter [a-zA-Z]
digit [0-9]
id {letter}+({letter}|{digit})*
Int	("I"|"i")("N"|"n")("T"|"t")
Strin	"\""(((.)|([\n])|([\t])|([\r]))*)"\""
space [ ]

%%
";"		{return SEM;}

[0-9]+   	{ 
			//printf("%s is a number \n", yytext); 			
			sscanf(yytext,"%d",&yylval.intVal); 
			return NUMBER; 
		} 
{Strin}		{	
				yylval.ids = yytext;
				return STR;
		}
{Int}		{
				
				return INTNUM;
		}
[Pp][Rr][Ii][Nn][Tt]   {return PRI;}

{id}            {
			yylval.ids = yytext;
			return ID;
		}
[\n]   { yylineno++; return '\n';}
[ \t]   ;

.   { return yytext[0]; }

%%
int yywrap()
{
    return 1;
}

