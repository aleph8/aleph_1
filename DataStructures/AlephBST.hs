--------------------------------------------------------------------
-- Autor : Aleph8                                                 --
-- Descripción : Binary Search Tree                               --
-- Fecha: 04 / 02 / 22                                            --
--------------------------------------------------------------------

module AlephBST(BSTA,
                empty,
                isEmpty,
                insert,
                isElem,
                listToBST,
                minElem,
                maxElem,
                delElem,
                treeSort) where 

data BSTA a = Empty | Node a (BSTA a) (BSTA a)

empty :: BSTA a 
empty = Empty

isEmpty :: BSTA a -> Bool
isEmpty Empty = True
isEmpty _ = False

uniBST :: a -> BSTA a 
uniBST x = (Node x Empty Empty)

--inserta el elemento siguiendo el patrón característico del BST
insert :: (Ord a) => a -> BSTA a -> BSTA a 
insert x Empty = (Node x Empty Empty)
insert x (Node x' Empty Empty) 
    | x == x' = (Node x Empty Empty)
    | x < x' = (Node x' (uniBST x) Empty)
    | otherwise = (Node x' Empty (uniBST x))
insert x t 
    | x == x' = (Node x l r)
    | x < x' = (Node x' (insert x l) r)
    | otherwise = (Node x' l (insert x r))
    where 
        (Node x' l r ) = t

--Comprueba si un elemento está en el árbol
isElem:: (Ord a) => a -> BSTA a -> Bool
isElem x Empty = False
isElem x (Node x' Empty Empty) = if x == x' then True else False
isElem x (Node x' l r)
    | x == x' = True
    | x < x' = isElem x l 
    | otherwise = isElem x r


--Recorrido en Orden
inOrderBST :: BSTA a -> [a]
inOrderBST Empty = []
inOrderBST (Node x l r) = (inOrderBST l) ++ [x] ++ (inOrderBST r)

--Transforma una lista en un BST
listToBST :: (Ord a) => [a] -> BSTA a
listToBST xs = foldr insert Empty xs 

-- Algoritmo que ordena una lista aprovechando que 
-- el recorrido en orden de un arbol BST nos ordena 
-- las componentes 
treeSort :: (Ord a) => [a] -> [a]
treeSort xs = inOrderBST (listToBST xs)

--Devuelve el minimo elemento 
minElem :: BSTA a -> a
minElem Empty = error "min elem on empty tree"
minElem (Node x Empty _) = x
minElem (Node x l _) = minElem l

--Devuelve el maximo elemento
maxElem :: BSTA a -> a
maxElem Empty = error "maxElem on empty tree"
maxElem (Node x _ Empty) = x 
maxElem (Node x _ r) = maxElem r 

-- Elimina el elemento del BST manteniendo su invariante
delElem :: (Ord a) => a -> BSTA a -> BSTA a 
delElem z Empty = Empty 
delElem z (Node x Empty Empty) = if z == x then Empty else (Node x Empty Empty)
delElem z (Node x l Empty) 
    | x == z = l 
    | z < x = (Node x (delElem z l) Empty)
    | otherwise = (Node x l Empty)
delElem z (Node x Empty r) 
    | x == z = r
    | z > x = (Node x Empty (delElem z r))
    | otherwise = (Node x Empty r)
delElem z (Node x l r)
    | x == z = (Node m l (delElem m r))
    | z < x = (Node x (delElem z l) r)
    |otherwise = (Node x l (delElem z r))
    where 
        m = (minElem r)
