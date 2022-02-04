Repositorio donde están alojadas Estructuras de Datos de interés, así como su implementación por mi parte.

-------------------------------------------------------------------------------------------------------------------------

<pre>
TreeA -> Árbol de aridad (número de hijos de un nodo) n sin ninguna restricción. 
Un árbol es una estructura de datos no lineal que establece una relación jerárquica entre sus objetos; 
son esenciales en la organización de datos.

<p align="center">
  <img src="https://user-images.githubusercontent.com/91496152/152160292-4db9db7d-ba28-4b70-9125-d9cd003f190f.png" />
</p>

Ejemplo gráfico del funcionamiento de la estructura (gracias a la clase "DrawTree.hs",
creada por Pepe Gallardo para la asignatura DataStructures en la Universidad de Málaga)
</pre>

-------------------------------------------------------------------------------------------------------------------------

<pre>
TreeAB -> Árbol Binario (aridad 2)


<p align="center">
  <img src="https://user-images.githubusercontent.com/91496152/152164088-18a47abc-d92c-4b69-8d08-e778a8e935c7.svg" />
</p>
</pre>

-------------------------------------------------------------------------------------------------------------------------

<pre>
BinaryHeapAleph: implementación de un árbol binario completo que satisface la propiedad HOP.

<p align="center">
  <img src="https://user-images.githubusercontent.com/91496152/152165042-6bac903c-e166-4652-a53c-c545d0cdfd0c.svg" />
</p>

HOP : la secuencia de cualquier camino desde la raíz a una hoja siempre es ascendente

Árbol binario completo: todos sus niveles están completos salvo el último, en el cual todos 
los nodos estan pegados a la izquierda

Cabe destacar que los montículos se suelen implementar vía árboles binarios aumentados; en este caso está implementado 
mediante un árbol binario no aumentado.


</pre>

-------------------------------------------------------------------------------------------------------------------------

<pre>
maxHeapAleph: implementación de un árbol binario aumentado que satisface la propiedad HOP

<p align="center">
  <img src="https://user-images.githubusercontent.com/91496152/152341904-73af841b-d892-4f9d-9e40-1941351c4ea7.svg" />
</p>

Un árbol binario aumentado es similar a un árbol binario normal, solo que en cada nodo se almacena también su peso
</pre>

-------------------------------------------------------------------------------------------------------------------------

<pre>
AlephBST: implementación de un BST (Binary Search Tree)

<p align="center">
  <img src="https://user-images.githubusercontent.com/91496152/152518468-dac91de0-d5d3-4692-bbcb-9eb06509e776.svg" />
</p>

Para cada nodo  todos los elementos situados a la izquierda serán menores; los elementos a la derecha mayores.

</pre>


