%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <tabla_simbolos.c>

int yylex(); 
int yyerror(const char *p) { printf("error");}
%}

%union {
	char *cadena;
	char *tipoDato;
	char *bloqueCodigo;
	char simbolo;
	int numero;
};


%token <simbolo> PA PC LLA LLC ASIGNACION OP_LOGIC OP_SUMA OP_RESTA OP_PROD OP_DIV FIN_LINEA CICLO CONDICION SINO START END
%token <cadena> STRING VAR_NAME
%token <numero> BOOLEAN DIGIT INTEGER
%token <tipoDato> VAR_TYPE

%type <numero> comparacion termino factor operacion
%type <bloqueCodigo> condicional asignacion expresion

%%
programa: START bloque END

bloque : linea bloque | linea

linea : expresion FIN_LINEA

expresion: asignacion | condicional

/*PLACEHOLDER: EN LUGAR DE V_TIPO, TIENE QUE HABER UNA LLAMADA A UNA FUNCION QUE CONSULTE EL TIPO EN LA TABLA DE SIMBOLOS*/

operacion: operacion OP_SUMA termino { $$ = validarTipo($1, $2, getTipo($3)); }
	   | operacion OP_RESTA termino { $$ = validarTipo($1, $2, getTipo($3));}
	   | termino

termino: termino OP_PROD factor {$$ = validarTipo($1, $2, getTipo($3));}
	 | termino OP_DIV factor {$$ = validarTipo($1, $2, getTipo($3));}
	 | factor

factor: INTEGER {$$ = 'i';}| BOOLEAN {$$ = 'b';} | PA operacion PC { $$ = getTipo('$2');} 


/* "agregarATablaDeSimbolos" es una funcion que chequea el nombre de la variable para asegurarse que no este agregada, despues compara el contenido de VAR_TYPE con un string que este hardcodeado definiendo el nombre del tipo (por ejemplo, "Boolean") y agrega a la tabla el nombre de la variable como clave y el tipo como valor (unBoolean, 'b')*/

asignacion : VAR_TYPE VAR_NAME ASIGNACION operacion { $$ = agregarATablaDeSimbolos($1, $2); } | VAR_TYPE VAR_NAME ASIGNACION STRING {$$ = agregarATablaDeSimbolos($1, $2);}

condicional : CONDICION PA comparacion PC LLA bloque LLC {$$ = $3;}

comparacion : VAR_NAME OP_LOGIC VAR_NAME { $$ = validarTipo ($1, $2, getTipo($3));}| VAR_NAME OP_LOGIC expresion { $$ = validarTipo ($1, $2, $3);}| expresion OP_LOGIC VAR_NAME { $$ = validarTipo ($1, $2, $3);}| expresion OP_LOGIC expresion { $$ = validarTipo ($1, $2, $3);}




%%


char validarTipo(char tipo1, char operador, char tipo2){
  if (tipo1 == tipo2) {

    if (operador == OP_LOGIC) {
      if (tipo2 == 'b') {
        return 'b';
      }
      else{
        yyerror("Error: Operacion no permitida");
      }
    }
    else {
      if (operador == OP_SUMA || operador == OP_RESTA || operador == OP_PROD || operador == OP_DIV) {
        if (tipo2 == 'i') {
          return 'i';
        }
        else{
          yyerror("Error: No se estan sumando enteros");
        }
      }
      else{
        yyerror("Error:Tipo de operador desconocido");
      }
    }
  }
  else{
    yyerror("Error: tipos de variable incompatibles");
  }

};

void agregarATablaDeSimbolos(char *varType, char *varName){
  if (strcmp(varType, "Boolean")){
    insertar (varName, 'b');
  } else if ( strcmp(varType, "Integer")){
    insertar (varName, 'i');
  } else if (strcmp (varType, "String")){
    insertar (varName, 's');
  } else {
    yyerror ("todo mal, no reconozco el tipo de variable");
  }
};

int main (){
	
	yyparse ();
	return 0;

}


