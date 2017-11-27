# Problem

Given two strings ss and tt, tt is a substring of ss if tt is
contained as a contiguous collection of symbols in ss (as a result, tt
must be no longer than ss).

The position of a symbol in a string is the total number of symbols
found to its left, including itself (e.g., the positions of all
occurrences of 'U' in "AUGCUUCAGAAAGGUCUUACG" are 2, 5, 6, 15, 17, and
18). The symbol at position ii of ss is denoted by s[i]s[i].

A substring of ss can be represented as s[j:k]s[j:k], where jj and kk
represent the starting and ending positions of the substring in ss;
for example, if ss = "AUGCUUCAGAAAGGUCUUACG", then s[2:5]s[2:5] =
"UGCU".

The location of a substring s[j:k]s[j:k] is its beginning position jj;
note that tt will have multiple locations in ss if it occurs more than
once as a substring of ss (see the Sample below).

Given: Two DNA strings ss and tt (each of length at most 1 kbp).

Return: All locations of tt as a substring of ss.

cf: http://rosalind.info/problems/subs/
