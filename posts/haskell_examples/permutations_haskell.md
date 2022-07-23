# Permutations of a list


Here we implement a naive algorithm for permutations in Haskell. For that, let us consider the list `[1, 2, 3]` as a test case. Our main strategy is to employ a _recursive_ algorithm.

The permutations of the list `[1, 2, 3]` can be obtained as follows: we first compute all the permutations which start with `1`, while denoting the permutations of the two remaining slots by `perm([2, 3])` (which are simply `[2, 3]` and `[3, 2]`). We then repeat the process for permutations which start with `2` and `3` and combine all of them afterwards. This procedures yields the following equivalence (we commit a slight abuse of notation here, where `1:perm([2, 3])` means that we prepend `1` to all the sub-lists in `perm([2, 3])`):

```
perm([1, 2, 3]) = [1: perm([2, 3]), 2: perm([1, 3]), 3: perm([1, 2])]
```

The term `1: perm([2, 3])`, for example, would yield the permutations `[1, 2, 3]` and `[1, 3, 2]`

Hence, we can, given a list $\ell = (l_1, l_2, ..., l_n)$, construct the following recurrence for its permutations:

$$
 \mathcal{P}(\ell) = (l_1, \mathcal{P}(l_2, ..., l_n))
 +(l_2, \mathcal{P}(l_1, ..., l_n))
 +...
 +(l_n, \mathcal{P}(l_1, ..., l_{n-1})).
$$

Naturally, the base case is $\mathcal{P}(\emptyset)= \emptyset$ for an empty list.

We should be able to do two things in order to implement this algorithm: **i)** find out how to remove the &nbsp; <img src="http://latex.codecogs.com/svg.latex?k"/>-th element in a list, in order to obtain the desired sub-lists, and we should also be able to know **ii)** how to implement the recurrence above.  The following function implements the first routine:

```haskell
-- Removes the n-th element of the list
removeAt :: Int -> [a] -> [a]
removeAt 0 (x:xs) = xs
removeAt n (x:xs) = x : (removeAt (n-1) xs)
```

The question now is how to use the function above to get _all_ the sub-lists which have exactly one element less than the original one. For instance, in our example we have the list `[1, 2, 3]` - how can we get the sub-lists `[1, 2]`, `[1, 3]` and `[2, 3]`? A possible approach is to use map twice:

```haskell
-- Returns all the sub-lists with one element remove, e.g.
-- removeMap [1, 2, 3] = [[1, 2], [1, 3], [2, 3]]
removeMap :: [a] -> [[a]]
removeMap lst = map (\func -> func lst) f' where
  f' = map removeAt [0..((length lst)-1)]
```

One way to interpret the helper function `f'` is as a "list of partial functions", namely `f' = [removeAt 0, removeAt 1, removeAt 2, ..., removeAt n]`. Then, we just need to apply each one of them to our original list. This is precisely what the line `removeMap lst = map (\func -> func lst) f'` does. This line applies each of the partial functions to the original list, yielding `[removeAt 0 lst, removeAt 1 lst, removeAt 2 lst, ..., removeAt n lst]`. This is actually a pretty useful strategy to apply map to a function with several arguments! If we feed our original list to this function we get the desired output:

```haskell
*Main> removeMap [1, 2, 3]
[[2,3],[1,3],[1,2]]
```

Finally, the implementation of the recursion is:

```haskell
-- Returns all the permutations. This can be done recursively
perm :: [a] -> [[a]]
perm [] = [[]]
perm lst = concat $ zipWith (\x -> map (x:)) lst (map perm (removeMap lst))
```
Here `map perm (removeMap lst)` returns the list `[perm([2, 3]), perm([1, 3]), perm([1, 2])]`, in our example. We should now prepend the list elements `[1, 2, 3]` to these sub-lists in order to get terms like `1:perm([2, 3])` and so on. The function `zipWith` from the prelude associate each term with its sub-list, in other words, it associates `1` with `perm([2, 3])`, `2` with `perm([1, 3])` and so on. Finally, the anonymous function `(\x -> map (x:))` is what allows us to prepend `1` to every sub-list in  `perm([2, 3])`:

```haskell
*Main> perm [2, 3]
[[2,3],[3,2]]
*Main> (\x -> map (x:)) 1 (perm [2, 3])
[[1,2,3],[1,3,2]]
```

The function `concat` simply flattens the results, guaranteeing that we get a type signature ```[[a]]``` instead of `[[[a]]]`. We can now see this function in action:

```haskell
*Main> perm [1, 2, 3]
[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
*Main> perm [1]
[[1]]
*Main> perm "aba"
["aba","aab","baa","baa","aab","aba"]
```

Full code [here](https://github.com/alves-gabriel/haskell_projects/blob/main/standalone_problems/permutations.hs).
