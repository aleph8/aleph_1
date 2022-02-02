module TreeA(TreeA,
            isEmpty,
            weight,
            height,
            isElemA,
            sumTreeA,
            pathTo,
            atLevelA,
            foldA
            ) where 


--------------------------------------------------------------------
-- Autor : Aleph8                                                 --
-- Descripción : simple implementacion de un arbol                --
-- Fecha: 02 / 02 / 22                                            --
--------------------------------------------------------------------


import DataStructures.Graphics.DrawTrees

data TreeA a = EmptyA | Node a [TreeA a] deriving Show

tree :: TreeA Integer
tree = Node 5 [Node 1 [Node 4 [], Node 7 [Node 8 [],Node 5 [],Node 3 []]],Node 2 [],Node 3 []]

empty :: TreeA a 
empty = EmptyA

isEmpty :: TreeA a -> Bool
isEmpty EmptyA = True
isEmpty _ = False

weight :: TreeA a -> Int
weight EmptyA = 0
weight (Node x []) = 1
weight (Node x ls) = 1 + sumA [weight l | l <- ls]

sumA :: (Num a) => [a] -> a
sumA [] = 0
sumA [x] = x
sumA (x:xs) = x + sum xs

sumTreeA :: (Num a) => TreeA a -> a
sumTreeA EmptyA = 0
sumTreeA (Node x []) = x
sumTreeA (Node x xs) = x + sumA [sumTreeA s | s <- xs]

height :: (Ord a) => TreeA a -> Integer
height EmptyA = 0
height (Node x []) = 1
height (Node x ls) = 1 + maximum [height l | l <- ls]

atLevelA :: (Ord a) => Integer -> TreeA a -> [a]
atLevelA _ EmptyA = []
atLevelA 0 (Node x _) = [x] 
atLevelA n (Node x ls) 
    | n >= height (Node x ls) = []
    | otherwise = uniList [atLevelA (n-1) l | l <- ls]

uniList :: [[a]] -> [a]
uniList [] = []
uniList [[x]] = [x]
uniList (x:xs) = x ++ uniList xs

pathTo:: (Eq a ) =>  a -> TreeA a -> [[a]]
pathTo _ EmptyA = []
pathTo z (Node x ls )
    | z == x = [z] : aux
    | otherwise = aux
    where 
        aux = map (x:) (uniList [pathTo z l | l <- ls])

isElemA:: (Eq a) => a -> TreeA a -> Bool
isElemA _ EmptyA = False
isElemA z (Node x ls) 
    | z == x = True
    | otherwise = foldr (||) False [isElemA z l | l <- ls]

preOrderSearch :: TreeA a -> [a]
preOrderSearch EmptyA = []
preOrderSearch (Node x []) = [x]
preOrderSearch (Node x ls) = x : (uniList [preOrderSearch l | l <- ls])


foldA :: (a -> b -> b) -> b -> TreeA a -> b
foldA f n t = foldr f n (preOrderSearch t)




----------------------------Draw--------->
instance Subtrees (TreeA a) where
  subtrees EmptyA = []
  subtrees (Node x ys)  = ys

  isEmptyTree  = isEmpty

instance (Show a) => ShowNode (TreeA a) where
  showNode (Node x _)  = show x

drawOnWith :: FilePath -> (a -> String) -> TreeA a -> IO ()
drawOnWith file toString  = _drawOnWith file showTreeA
 where
  showTreeA (Node x _)  = toString x

