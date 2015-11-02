%option noyywrap
%option yylineno


%{
#include <stdio.h>
#include <tp.tab.h>
%}

OP_SUMA "+"
OP_RESTA"-"
OP_PROD "*"
OP_DIV "/"
OP_LOGIC "!"|"&&"|"||"|">"|"<"|"=="|"<="|">="
DIGIT    -?[0-9]
INTEGER	 -?[0-9]{2,}
STRING ["]{1}.{2,255}["]{1}
BOOLEAN "true"|"false"
VAR_NAME [a-z][a-zA-Z0-9]*
VAR_TYPE [A-Z][a-zA-Z0-9]*


%%


"start"				{ printf("START"); return START}
"end"				{ printf("END"); return END}
"("                 { printf("PA \n"); PA;}
")"                 { printf("PC \n"); PC;}
"{"                 { printf("LLA \n"); LLA;}
"}"                 { printf("LLC \n"); LLC;}
"ciclo"	    		{ printf("CICLO \n"); CICLO;}
"si"			    { printf("CONDICION \n"); CONDICION;}
"sino"			    { printf("SINO \n"); SINO;}
"="					{ printf("ASIGNACION \n"); return ASIGNACION;}
";"					{ printf("FINDELINEA \n"); return FIN_LINEA;}
{OP_SUMA}          	{ printf("SUMA \n"); OP_SUMA}
{OP_RESTA}          { printf("RESTA \n"); OP_RESTA}
{OP_PROD}          	{ printf("MULTIPLICACION \n"); return OP_MULT}
{OP_DIV}			{ printf("DIVISION \n"); return OP_DIV;}
{BOOLEAN}           { printf("BOOLEANO \n"); yylval.simbolo = yytext; return BOOLEAN;}
{STRING}		    { printf("STRING \n");strcpy(yylval.cadena, yytext); return STRING;}
{DIGIT}            	{ printf("DIGIT \n"); yylval.numero=atoi(yytext); return DIGIT;}
{INTEGER}           { printf("INTEGER \n"); yylval.numero=atoi(yytext); return INTEGER;}
{OP_LOGIC}       	{ printf("OPERADOR LOGICO \n"); yylval.simbolo = yytext; return OP_LOGIC;}
{VAR_NAME}          { printf("VARIABLE \n");strcpy(yylval.cadena, yytext); return VAR_NAME;}
{VAR_TYPE}			{ printf("TIPODEVARIABLE \n");strcpy(yylval.cadena, yytext); return VAR_TYPE}

[ \t\n]+            { } /* ignorar enters y tabs*/
.                   {printf("error lexico \n"),yylineno; exit(1);}

%%
int main (void) {
	return yylex ();
}


	