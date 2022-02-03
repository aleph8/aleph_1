--------------------------------------------------------------------
-- Autor : Aleph8                                                 --
-- Descripción : Montículo Maxifóbico implementado esta vez       --
--                  con un arbol binario aumentado                --
-- Fecha: 02 / 02 / 22                                            --
--------------------------------------------------------------------

module MaxHeapA(MaxHeapA,
                isEmpty,
                empty,
                size,
                getRoot,
                merge,
                insert,
                isElem,
                delElem,
                uniHeap,
                postOrder) where

data MaxHeapA a = Empty | Node a Int (MaxHeapA a) (MaxHeapA a) deriving Show

aleph :: MaxHeapA Char
aleph = (Node 'a' 5 (uniHeap 'l') (Node 'e' 3 (uniHeap 'p') (uniHeap 'h')))

empty :: MaxHeapA a 
empty = Empty

isEmpty :: MaxHeapA a -> Bool
isEmpty Empty = True 
isEmpty _ = False

size :: MaxHeapA a -> Int
size Empty = 0
size (Node _ n _ _) = n 


--Devuelve el primer elemento (el menor debido a la organizacion siguiendo HOP)
getRoot :: MaxHeapA a -> a
getRoot Empty = error "Empty Heap"
getRoot (Node n _ _ _) = n


-- Metodo auxiliar en el cual se apoya el metodo principal "merge" de complejidad logaritmica
-- de los tres argumentos que recibe del "merge" el que tenga mayor peso lo atribuye como hijo 
-- inmediato del arbol resultante, en este caso el izquierdo. Los arboles restantes se mezclan de 
-- nuevo pasando a ser el hijo derecho.
mergeAux :: (Ord a) => a -> Int -> MaxHeapA a -> MaxHeapA a -> MaxHeapA a -> MaxHeapA a
mergeAux z nodes h Empty Empty = Node z nodes h Empty
mergeAux z nodes h h2 Empty = Node z nodes h h2 
mergeAux z nodes h Empty h2 = Node z nodes h2 h
mergeAux z nodes h h2 h3
  | n > n' && n' > n'' = Node z nodes h (merge h2 h3)
  | n' > n && n > n'' = Node z nodes h2 (merge h h3)
  |otherwise = Node z nodes h3 (merge h h2)
  where 
    (Node x n l r) = h
    (Node x' n' l' r') = h2
    (Node x'' n'' l'' r'') = h3

-- Metodo principal 
merge :: (Ord a) => MaxHeapA a -> MaxHeapA a -> MaxHeapA a
merge Empty Empty = Empty
merge s Empty = s
merge Empty s = s 
merge h1 h2
  | x < x' = mergeAux x nodes h2 l r 
  | otherwise = mergeAux x' nodes h1 l' r'
  where 
    nodes = n + n'
    (Node x n l r) = h1
    (Node x' n' l' r') = h2

-- Crea un Heap de un elemento
uniHeap :: a -> MaxHeapA a 
uniHeap x = (Node x 1 Empty Empty)

--Insertamos. Gracias a merge se inserta eficientemente [O(logn)]
insert :: (Ord a) => a -> MaxHeapA a -> MaxHeapA a 
insert x Empty = uniHeap x 
insert x h1 = merge (uniHeap x) h1

--Eliminamos la raiz; posteriormente mezclamos las dos ramas
delRoot :: (Ord a) => MaxHeapA a -> MaxHeapA a 
delRoot Empty = Empty
delRoot (Node x 1 _ _) = Empty
delRoot (Node x _ l r ) = merge l r

-- Comprobamos si un elemento está en el monticulo maxifobico
isElem :: (Ord a,Eq a) => a -> MaxHeapA a -> Bool
isElem x Empty = False
isElem x (Node x' 1 _ _) = if x == x' then True else False
isElem x (Node x' n l r) 
    | x < x' = False
    | x == x' = True
    |otherwise = False || (isElem x l) || (isElem x r)

-- Eliminamos cualquier elemento del montículo
delElem :: (Ord a,Eq a) => a -> MaxHeapA a -> MaxHeapA a
delElem _ Empty = Empty
delElem x (Node x' 1 _ _) = if x == x' then Empty else (Node x' 1 Empty Empty)
delElem x (Node x' n l r) 
    | x == x' = delElem x (merge l r)
    | x < x' = (Node x' n l r)
    | (isElem x l) && not(isElem x r) = (Node x' (n-1) (delElem x l) r)
    | not(isElem x l) && (isElem x r) = (Node x' (n-1) l (delElem x r))
    | otherwise = (Node x (n-2) (delElem x l) (delElem x l))

-- Recorrido post-orden  
postOrder :: MaxHeapA a -> [a]
postOrder Empty = []
postOrder (Node x 1 _ _) = [x]
postOrder (Node x n l r) = (postOrder l)  ++ (postOrder r) ++ [x]