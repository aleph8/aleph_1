module TreeAB(TreeAB,
            isEmptyAB,
            heightAB,
            weightAB,
            pathsToAB,
            borderAB,
            isElemAB,
            atLevelAB) where

--------------------------------------------------------------------
-- Autor : Aleph8                                                 --
-- Descripción : simple implementacion de un arbol binario        --
-- Fecha: 02 / 02 / 22                                            --
--------------------------------------------------------------------

data TreeAB a = EmptyAB | Node a (TreeAB a) (TreeAB a) deriving Show

treeab :: TreeAB Integer
treeab = Node 1 (Node 2 (Node 4 (EmptyAB) (EmptyAB)) (EmptyAB)) (Node 3 (EmptyAB) (EmptyAB))

emptyAB :: TreeAB a 
emptyAB = EmptyAB

isEmptyAB :: TreeAB a -> Bool
isEmptyAB EmptyAB = True
isEmptyAB _ = False

weightAB :: TreeAB a -> Integer
weightAB EmptyAB = 0
weightAB (Node x EmptyAB EmptyAB) = 1
weightAB (Node x l r) = 1 + (weightAB l) + (weightAB r)

heightAB :: TreeAB a -> Integer
heightAB EmptyAB = 0
heightAB (Node x EmptyAB EmptyAB) = 1
heightAB (Node x l r ) = 1 + maximum [heightAB l , heightAB r]

borderAB :: TreeAB a -> [a]
borderAB EmptyAB = []
borderAB (Node x EmptyAB EmptyAB) = [x]
borderAB (Node x l r) = (borderAB l) ++ (borderAB r)

isElemAB :: (Eq a) => a -> TreeAB a -> Bool
isElemAB z EmptyAB = False
isElemAB z (Node x EmptyAB EmptyAB) = if z == x then True else False
isElemAB z (Node x l r) 
    | z == x = True
    | otherwise = False || isElemAB z l || isElemAB z r

atLevelAB :: Integer -> TreeAB a -> [a]
atLevelAB _ EmptyAB = []
atLevelAB 0 (Node x _ _) = [x]
atLevelAB n (Node x l r) = (atLevelAB (n-1) l) ++ (atLevelAB (n-1) r)

pathsToAB :: (Eq a) =>  a -> TreeAB a -> [[a]]
pathsToAB _ EmptyAB = []
pathsToAB z (Node x l r) 
    | x == z = [z] : ax
    | otherwise = ax
    where 
        ax = map (x:) ((pathsToAB z l) ++ (pathsToAB z r))

inOrderAB :: TreeAB a -> [a]
inOrderAB EmptyAB = []
inOrderAB (Node x EmptyAB EmptyAB) = [x]
inOrderAB (Node x l r) = (inOrderAB l) ++ [x] ++ (inOrderAB r)

preOrderAB :: TreeAB a -> [a]
preOrderAB EmptyAB = []
preOrderAB (Node x EmptyAB EmptyAB) = [x]
preOrderAB (Node x l r) = [x] ++ (preOrderAB l) ++ (preOrderAB r)

postOrderAB :: TreeAB a -> [a]
postOrderAB EmptyAB = []
postOrderAB (Node x EmptyAB EmptyAB) = [x]
postOrderAB (Node x l r) = (postOrderAB l) ++ (postOrderAB r) ++ [x]

foldAB :: (a -> b -> b) -> b -> TreeAB a -> b
foldAB f z t = foldr f z (inOrderAB t)
