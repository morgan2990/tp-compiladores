%option noyywrap
%option yylineno


%{
#include <stdio.h>
#include "tp.tab.h"
%}

OP_SUMA "+"
OP_PROD "*"
OP_LOGIC "!"|"&&"|"||"|">"|"<"|"=="|"<="|">="
DIGIT    -?[0-9]
INTEGER	 -?[0-9]{2,}
STRING ["]{1}.{2,255}["]{1}
BOOLEAN "true"|"false"
VAR_NAME [a-z][a-zA-Z0-9]*
VAR_TYPE [A-Z][a-zA-Z0-9]*


%%


"start"				{ printf("START"); return START;}
"end"				{ printf("END"); return END;}
"("                 { printf("PA \n"); return PA;}
")"                 { printf("PC \n"); return PC;}
"{"                 { printf("LLA \n"); return LLA;}
"}"                 { printf("LLC \n"); return LLC;}
"ciclo"	    		{ printf("CICLO \n"); return CICLO;}
"si"			    { printf("CONDICION \n"); return CONDICION;}
"sino"			    { printf("SINO \n"); return SINO;}
"="					{ printf("ASIGNACION \n"); return ASIGNACION;}
";"					{ printf("FINDELINEA \n"); return FIN_LINEA;}
{OP_SUMA}          	{ printf("SUMA \n"); return OP_SUMA;}
{OP_PROD}          	{ printf("MULTIPLICACION \n"); return OP_PROD;}
{BOOLEAN}           { printf("BOOLEANO \n"); yylval.numero = atoi(yytext); return BOOLEAN;}
{STRING}		    { printf("STRING \n");strcpy(yylval.cadena, yytext); return STRING;}
{DIGIT}            	{ printf("DIGIT \n"); yylval.numero=atoi(yytext); return DIGIT;}
{INTEGER}           { printf("INTEGER \n"); yylval.numero=atoi(yytext); return INTEGER;}
{VAR_NAME}          { printf("VARIABLE \n");strcpy(yylval.cadena, yytext); return VAR_NAME;}
{VAR_TYPE}			{ printf("TIPODEVARIABLE \n");strcpy(yylval.cadena, yytext); return VAR_TYPE;}

[ \t\n]+            { } /* ignorar enters y tabs*/

. {printf("ERROR LEXICO EN LINEA %d \n",yylineno);} 

%%



	