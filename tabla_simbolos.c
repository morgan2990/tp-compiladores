#include <stdio.h>
#include <string.h>

typedef struct variable {
  char nombre[255];
  char tipo;
} Variable;

typedef struct tabla {
  Variable * variables[50];
} Tabla;

/*https://en.wikipedia.org/wiki/C_dynamic_memory_allocation*/

Tabla tablaDeSimbolos;

/*Definicion de funciones*/
Tabla crear();
int insertar(char nombre[255],char tipo);
void remover(char nombre[255]);
char getTipo(char nombre[255]);
int existe(char nombre[255]);


/*Implementacion de funciones*/

/* Crea una tabla de signos y reserva espacio en memoria*/
Tabla crear(){

      int i=0;
      for (i; i<50; i++){
        
        tablaDeSimbolos.variables[i] = NULL;  
      
      }

      return tablaDeSimbolos;
     
}
     
int insertar(char nombre[255],char tipo){

     if (existe(nombre)==0){
     
                            
             Variable * temp;
             temp = malloc(sizeof(Variable));
             strcpy(temp->nombre,nombre);
             temp->tipo = tipo;

             int i = 0;
             for (i; i<50; i++){
         
             if (tablaDeSimbolos.variables[i] == NULL){       
                                                     
                 tablaDeSimbolos.variables[i] = temp;
                 return 1;

             }

         }                                           
                                                 
     }
     
     return 0;

}

void remover(char nombre[255]){
     
     if (existe(nombre)==1){
      
      /*Remover*/                                            
                                                 
     }
     
}


char getTipo(char nombre[255]){
     
     if (existe(nombre)==1){
      
        int i=0; 
        
        for (i; i<50; i++){
            
           if (tablaDeSimbolos.variables[i]!=NULL && strcmp(tablaDeSimbolos.variables[i]->nombre, nombre)==0){

             return tablaDeSimbolos.variables[i]->tipo;
                                                      
            }
           
            
        }                                                 
     }
     
     return 'u';   
}

int existe(char nombre[255]){

       int i=0;
      
       for (i; i<50; i++){
         
         if (tablaDeSimbolos.variables[i]!=NULL){
             
             if (strcmp(tablaDeSimbolos.variables[i]->nombre, nombre)==0){
                                  
               return 1;
               
               }

         }
       }
       
       return 0;
        
}

void test(){

     printf("Creando tabla... \n");
     crear();
     printf("Tabla creada con exito! \n");     
     printf("Insertando variables en tabla... \n");
     insertar("a",'n');
     insertar("b",'n');
     insertar("pruebaString",'s');
     insertar("a",'n');
     insertar("b",'n');
     insertar("b",'n');
     insertar("pruebaBoolean",'b');
     printf("Variables insertadas con exito! \n");    
     printf("Validando valores insertados... \n");
     int i=0;
     for (i;i<10;i++){
      
         if (tablaDeSimbolos.variables[i]!=NULL){
            printf("Tabla de simbolos en posicion %d | %s | %c \n",i,tablaDeSimbolos.variables[i]->nombre, getTipo(tablaDeSimbolos.variables[i]->nombre));
            }
     }
     printf("Test concluido! \n");
     
     
}

main(){

    //test();
    //system("PAUSE");
    return 0;
       
}
