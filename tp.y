%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "tabla_simbolos.c"

int yylex(); 
void yyerror(const char *p) { printf("%s \n", p);}/*En esta linea modifiqué los parametros de yyerror, ademas cambié el tipo de retorno de int a void*/
char validarTipo(char tipo1, char operador, char tipo2); /*Declaré la función*/
void agregarATablaDeSimbolos(char varType[255], char varName[255]); /*Declaré la función*/
%}

%union {
  char cadena[255];
  char tipoDato;
  char bloqueCodigo[255];
  char simbolo;
  int numero;
};


%token <simbolo> PA PC LLA LLC ASIGNACION /*OP_LOGIC*/ OP_SUMA OP_RESTA OP_PROD OP_DIV FIN_LINEA CICLO CONDICION SINO START END
%token <cadena> STRING VAR_NAME VAR_TYPE
%token <numero> BOOLEAN DIGIT INTEGER

%type <numero> termino factor operacion
%type <bloqueCodigo> asignacion

%%
programa: START bloque END

bloque : linea bloque | linea

linea : asignacion FIN_LINEA

asignacion : VAR_TYPE VAR_NAME ASIGNACION operacion { agregarATablaDeSimbolos($1, $2); } | VAR_TYPE VAR_NAME ASIGNACION STRING {agregarATablaDeSimbolos($1, $2);}

operacion: operacion OP_SUMA termino { $$ = validarTipo($1, $2, $3); }
     | termino

termino: termino OP_PROD factor {$$ = validarTipo($1, $2, $3);}
   | factor

factor: INTEGER {$$ = 'i';}| PA operacion PC { $$ = $2;} 

/* "agregarATablaDeSimbolos" es una funcion que chequea el nombre de la variable para asegurarse que no este agregada, despues compara el contenido de VAR_TYPE con un string que este hardcodeado definiendo el nombre del tipo (por ejemplo, "Boolean") y agrega a la tabla el nombre de la variable como clave y el tipo como valor (unBoolean, 'b')*/



/*comparacion : VAR_NAME OP_LOGIC VAR_NAME { $$ = validarTipo ($1, $2, getTipo($3));}| VAR_NAME OP_LOGIC operacion { $$ = validarTipo ($1, $2, $3);}| operacion OP_LOGIC VAR_NAME { $$ = validarTipo ($1, $2, $3);}| operacion OP_LOGIC operacion { $$ = validarTipo ($1, $2, $3);} | BOOLEAN {$$ = 'b';}*/

/*condicional : CONDICION PA comparacion PC LLA bloque LLC {$$ = $3;}*/

%%


char validarTipo(char tipo1, char operador, char tipo2){
  if (tipo1 == tipo2) {

    
      if (operador == '+' || operador == '*') { /*En esta linea tiraba warning en OP_SUM y OP_PROD, lo reemplazé por  + y * */
        if (tipo2 == 'i') {
          return 'i';
        }
        else{
          yyerror("Error: No se estan sumando enteros"); /*En cada rama se agregó un return con una letra e para distinguir el return i*/
          return 'e';
        }
      }
      else{
        yyerror("Error:Tipo de operador desconocido");
        return 'e';
      }
    }
  else{
    yyerror("Error: tipos de variable incompatibles");
    return 'e';
  }
  return 'e';
};

void agregarATablaDeSimbolos(char varType[255], char varName[255]){
  if
   (strcmp(varType, "Boolean")){
    insertar (varName, 'b');
  } else if ( strcmp(varType, "Integer")){
    insertar (varName, 'i');
  } else if (strcmp (varType, "String")){
    insertar (varName, 's');
  } else {
    yyerror("Error al completar la tabla de simbolos"); /*En esta linea modifiqué los parametros de yyerror*/
  }
};

int main (){
  
  yyparse ();
  return 0;

}


