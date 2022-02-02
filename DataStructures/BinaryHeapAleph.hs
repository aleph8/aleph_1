
--------------------------------------------------------------------
-- Autor : Aleph8                                                 --
-- Descripción : Implementación de un BinaryHeap                  --
-- Fecha: 02 / 02 / 22                                            --
--------------------------------------------------------------------

module BHeap(BHeap,
             binaryHeapDemo,
             height,
             weight,
             isEmpty,
             empty,
             atLevel,
             insertA,
             deleteRoot) where 

data BHeap a = Empty | Node a (BHeap a) (BHeap a) deriving Show

--Devuelve un arbol con un único elemento
uniTree :: a -> BHeap a 
uniTree x = (Node x Empty Empty)

treeh :: BHeap Integer 
treeh = Node 1 (Node 2 (uniTree 4) (uniTree 5)) (uniTree 3)

--Genera montículos desde 0 hasta n (usado para probar la estructura)
binaryHeapDemo :: Integer -> BHeap Integer
binaryHeapDemo 0 = Empty
binaryHeapDemo n = insertA n (binaryHeapDemo (n-1))

-- Devuelve un empty BinaryHeap
empty :: BHeap a 
empty = Empty 

isEmpty :: BHeap a -> Bool
isEmpty Empty = True
isEmpty _ = False

--Devuelve el numero de nodos 
height :: BHeap a -> Integer
height Empty = 0
height (Node x Empty Empty) = 1
height (Node x l r ) = 1 + maximum [height l , height r]

--Devuelve la altura del arbol
weight :: BHeap a -> Integer
weight Empty = 0
weight (Node x Empty Empty) = 1
weight (Node x l r) = 1 + (weight l) + (weight r)

--Devuelve una lista con los elementos que tiene el arbol en ese nivel
atLevel :: Integer -> BHeap a -> [a]
atLevel _ Empty = []
atLevel 0 (Node x _ _) = [x]
atLevel n (Node x l r) = (atLevel (n-1) l) ++ (atLevel (n-1) r)

elemB :: [a] -> Integer
elemB [] = 0
elemB [x] = 1
elemB (x : xs ) = 1 + (elemB xs)

-- Propiedad de los arboles binarios completos
-- Cada elemento que se inserte lo hará manteniendo la estructura
-- de arbol binario completo

binaryC :: (Eq a) => a -> BHeap a -> BHeap a 
binaryC z Empty = (Node z Empty Empty)
binaryC z (Node x Empty Empty) = (Node x (uniTree z) Empty)
binaryC z (Node x l Empty) = (Node x l (uniTree z))
binaryC z (Node x Empty r) = (Node x (uniTree z) r)
binaryC z (Node x l r) 
    | ((weight l) == (weight r)) = newElement z (Node x l r)
    | otherwise = if elemB (atLevel (h-1) l) == 2 ^ (h-1) then (Node x l (binaryC z r)) else (Node x (binaryC z l) r)
            where 
            h = height l
            newElement z (Node x Empty Empty) = (Node x (uniTree z) Empty)
            newElement z (Node x l r) = (Node x (newElement z l) r)

--Insertamos al montículo binario manteniendo la propiedad HOP y
--el arbol binario completo; variante del algoritmo anterior

insertA :: (Eq a,Ord a) => a -> BHeap a -> BHeap a 
insertA z Empty = (Node z Empty Empty)
insertA z (Node x Empty Empty) = if (z > x) then (Node x (uniTree z) Empty) else (Node z (uniTree x) Empty)
insertA z (Node x l Empty) = if (z > x) then (Node x l (uniTree z)) else (Node z l (uniTree x))
insertA z (Node x Empty r) = if (z > x) then (Node x (uniTree z) r) else (Node z (uniTree x) r)
insertA z (Node x l r)
    | z < x = insertA x (Node z l r )
    | ((weight l) == (weight r)) = newElement z (Node x l r)
    | otherwise = if elemB (atLevel (h-1) l) == 2 ^ (h-1) 
        then if (x < z) then (Node x l (insertA z r)) else (Node z l (insertA x r))
        else if (x < z) then (Node x (insertA z l) r) else (Node z (insertA x l) r)
            where 
            h = height l
            newElement z (Node x Empty Empty) = if (z > x) then (Node x (uniTree z) Empty) else (Node z (uniTree x) Empty)
            newElement z (Node x l r) = if (z > x) 
                then (Node x (newElement z l) r)
                else (Node z (newElement x l) r)

inOrder :: BHeap a -> [a]
inOrder Empty = []
inOrder (Node x l r) = [x] ++ (inOrder l) ++ (inOrder r)

insList ::(Eq a,Ord a) => [a] -> BHeap a
insList [] = Empty
insList [x] = (Node x Empty Empty)
insList (x:xs) = insertA x (insList xs)


--Elimina la raíz conservando la estructura de BinaryHeap 
-- (HOP y arbol binario completo)
deleteRoot :: (Eq a, Ord a) => BHeap a -> BHeap a 
deleteRoot (Node x l r) = insList (inOrder l ++ (inOrder r))

