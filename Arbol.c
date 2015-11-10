#include <stdio.h>
#include <stdlib.h>


typedef struct Nodo {
	char clave [255];
	struct Nodo *izquierdo;
	struct Nodo *derecho;
} Nodo;

Nodo *agregarNodo(Nodo *arbol, char clave [255]);
Nodo *agregarNodoIzquierdo(Nodo *arbol, char clave [255]);
Nodo *agregarNodoDerecho(Nodo *arbol, char clave [255]);
Nodo *buscarNodo(Nodo *arbol, char clave [255]);
void imprimirPreOrden(Nodo *arbol);
void imprimirInOrden(Nodo *arbol);

//TODO agregar verificaciones por NULL


int main(int argc, char **argv) {

	Nodo *arbol = NULL;
	arbol = agregarNodo(arbol, "Programa");
	arbol = agregarNodoIzquierdo(arbol, "=");
	arbol = agregarNodoDerecho(arbol, "S");
	arbol = agregarNodoIzquierdo(arbol->izquierdo, "a");
	arbol = agregarNodoDerecho(arbol->izquierdo, "5");
	arbol = agregarNodoIzquierdo(arbol->derecho, "=");
	arbol = agregarNodoDerecho(arbol->derecho, "if");
	arbol = agregarNodoIzquierdo(arbol->derecho->izquierdo, "b");
	arbol = agregarNodoDerecho(arbol->derecho->izquierdo, "7");
	arbol = agregarNodoIzquierdo(arbol->derecho->derecho, "==");
	arbol = agregarNodoDerecho(arbol->derecho->derecho, "S");
	arbol = agregarNodoIzquierdo(arbol->derecho->derecho->izquierdo, "a");
	arbol = agregarNodoDerecho(arbol->derecho->derecho->izquierdo, "b");
	arbol = agregarNodoDerecho(arbol->derecho->derecho->derecho, "=");
	arbol = agregarNodoDerecho(arbol->derecho->derecho->derecho->izquierdo, "b");
	arbol = agregarNodoDerecho(arbol->derecho->derecho->derecho->izquierdo, "0");
	imprimirInOrden(arbol);

	
}

Nodo *agregarNodo(Nodo *arbol, char clave [255]) {
	Nodo *nuevoNodo = malloc(sizeof(Nodo));
	strcpy(nuevoNodo->clave, clave);
	nuevoNodo->izquierdo = NULL;
	nuevoNodo->derecho = NULL;

	
	arbol = nuevoNodo;
	
	return arbol;
}

Nodo *agregarNodoIzquierdo(Nodo *arbol, char clave [255]) {
	Nodo *nuevoNodo = malloc(sizeof(Nodo));
	strcpy(nuevoNodo->clave, clave);
	nuevoNodo->izquierdo = NULL;
	nuevoNodo->derecho = NULL;

	arbol->izquierdo = nuevoNodo;
		
	return arbol;
}

Nodo *agregarNodoDerecho(Nodo *arbol, char clave [255]) {
	Nodo *nuevoNodo = malloc(sizeof(Nodo));
	strcpy(nuevoNodo->clave, clave);
	nuevoNodo->izquierdo = NULL;
	nuevoNodo->derecho = NULL;

	arbol->derecho = nuevoNodo;

	return arbol;
}

void imprimirPreOrden(Nodo *arbol) {
	if (arbol != NULL) {
		printf(" %s", arbol->clave);
		imprimirPreOrden(arbol->izquierdo);
		imprimirPreOrden(arbol->derecho);
	}
}

void imprimirInOrden(Nodo *arbol) {
	if (arbol != NULL) {
		imprimirInOrden(arbol->izquierdo);
		if ((strcmp (arbol->clave, "Programa") == 0 || strcmp (arbol->clave, "S") == 0)){
			printf(" %s", arbol->clave);
		}
		imprimirInOrden(arbol->derecho);
	}
}

Nodo *buscarNodo(Nodo *arbol, char clave[255]) {
	if (arbol == NULL) {
		return NULL;
	}
	if (arbol->clave == clave) {
		return arbol;
	} else {
		buscarNodo (arbol->izquierdo, clave);
		buscarNodo (arbol->derecho, clave);
	}
}


