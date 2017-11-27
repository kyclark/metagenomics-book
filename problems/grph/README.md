# Problem

A graph whose nodes have all been labeled can be represented by an
adjacency list, in which each row of the list contains the two node
labels corresponding to a unique edge.

A directed graph (or digraph) is a graph containing directed edges,
each of which has an orientation. That is, a directed edge is
represented by an arrow instead of a line segment; the starting and
ending nodes of an edge form its tail and head, respectively. The
directed edge with tail vv and head ww is represented by (v,w)(v,w)
(but not by (w,v)(w,v)). A directed loop is a directed edge of the
form (v,v)(v,v).

For a collection of strings and a positive integer kk, the overlap
graph for the strings is a directed graph O[k] in which each string is
represented by a node, and string ss is connected to string tt with a
directed edge when there is a length kk suffix of ss that matches a
length kk prefix of tt, as long as s≠ts≠t; we demand s≠ts≠t to prevent
directed loops in the overlap graph (although directed cycles may be
present).

Given: A collection of DNA strings in FASTA format having total length
at most 10 kbp.

Return: The adjacency list corresponding to O[3]. You may return edges
in any order.

cf: http://rosalind.info/problems/grph/
