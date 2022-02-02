--------------------------------------------------------------------
-- Autor : Aleph8                                                 --
-- Descripción : pequeña implementacion de una Priority Queue     --
--               usando un BinaryHeap                             --
-- Fecha: 02 / 02 / 22                                            --
--------------------------------------------------------------------

module PQueue(isEmptyQ,
              enqueue,
              first,
              dequeue) where

import BinaryHeapAleph as PQueue

emptyQ :: PQueue.BHeap a 
emptyQ = PQueue.empty

isEmptyQ :: PQueue.BHeap a -> Bool
isEmptyQ = PQueue.isEmpty

enqueue ::(Ord a,Eq a) =>  a -> PQueue.BHeap a -> PQueue.BHeap a
enqueue z c = PQueue.insertA z c

first :: PQueue.BHeap a -> a 
first t = PQueue.getRoot t 

dequeue :: (Ord a) =>  PQueue.BHeap a -> PQueue.BHeap a
dequeue t = PQueue.deleteRoot t