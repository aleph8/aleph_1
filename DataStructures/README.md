Repository where Data Structures of interest are hosted, as well as their implementation by me.

-------------------------------------------------------------------------------------------------------------------------

<pre>
TreeA -> Tree of arity (number of children of a node) n without any restriction. 
A tree is a non-linear data structure that establishes a hierarchical relationship between its objects; 
are essential in data organization.

<p align="center">
  <img src="https://user-images.githubusercontent.com/91496152/152160292-4db9db7d-ba28-4b70-9125-d9cd003f190f.png" />
</p>

Graphical example of how the structure works (thanks to the class "DrawTree.hs",
created by Pepe Gallardo for the DataStructures course at the University of Málaga)
</pre>

-------------------------------------------------------------------------------------------------------------------------

<pre>
TreeAB -> Binary Tree (arity 2)


<p align="center">
  <img src="https://user-images.githubusercontent.com/91496152/152164088-18a47abc-d92c-4b69-8d08-e778a8e935c7.svg" />
</p>
</pre>

-------------------------------------------------------------------------------------------------------------------------

<pre>
BinaryHeapAleph: implementation of a complete binary tree that satisfies the HOP property.

<p align="center">
  <img src="https://user-images.githubusercontent.com/91496152/152165042-6bac903c-e166-4652-a53c-c545d0cdfd0c.svg" />
</p>

HOP : the sequence of any path from the root to a leaf is always ascending.

Complete binary tree: all its levels are complete except the last one, in which all nodes are stuck to the left. 
nodes are stuck to the left

It is worth noting that mounds are usually implemented via augmented binary trees; in this case it is implemented via a non-augmented binary tree. 

</pre>

-------------------------------------------------------------------------------------------------------------------------

<pre>
maxHeapAleph: implementation of an augmented binary tree satisfying the HOP property

<p align="center">
  <img src="https://user-images.githubusercontent.com/91496152/152341904-73af841b-d892-4f9d-9e40-1941351c4ea7.svg" />
</p>

An augmented binary tree is similar to a normal binary tree, except that its weight is also stored in each node.
</pre>

-------------------------------------------------------------------------------------------------------------------------

<pre>
AlephBST: implementation of BST (Binary Search Tree)

<p align="center">
  <img src="https://user-images.githubusercontent.com/91496152/152518468-dac91de0-d5d3-4692-bbcb-9eb06509e776.svg" />
</p>

For each node all elements on the left will be smaller; elements on the right will be larger.

</pre>


