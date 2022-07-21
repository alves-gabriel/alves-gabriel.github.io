# Gaussian Elimination

Here we show how Haskell can be used to obtain the echelon form of a matrix through Gaussian elimination. Albeit several approaches are possible, we focus on a strategy which uses ```foldr``` to implement the algorithm. For that, let us consider the matrix:

$$
M=
\begin{matrix}
\begin{pmatrix}
1 & 2 & 3\\\\4 & 5 & 6\\\\5 & 7 & 8
\end{pmatrix}
\end{matrix}
$$

We begin by constructing an elementary function called `subRow` which eliminates the leading number in a row. Given two rows
$(x_1, ..., x_m)$ and $(y_1, ..., y_m)$, we can eliminate the leading coefficient $y_1$ in the second row by performing the operation:

$$
(y_1, ..., y_m) 
\rightarrow 
(y_1, ..., y_m)  - 
\frac{y_1}{x_1} (x_1, ..., x_m).
$$

In the notation used below we eliminate the leading term from ```row2```:

```haskell
subRow :: [Float] -> [Float] -> [Float]
subRow row1 row2
  | head row1 /= 0  = zipWith (\x y-> x - (head row2)/(head row1)*y) row2　row1
  | otherwise       = 0 : (subRow (tail row1) (tail row2))
```

The guards here are used to avoid picking the trailing zeroes in a given row; we can just call the function recursively using its tail in order to neglect the leading zeroes. If we apply this to the first two rows we get:

```
*Main> subRow [1, 2, 3] [4, 5, 6]
[0.0,-3.0,-6.0]
```

Now we write a binary operation called `eliminate`, which is defined between a matrix (not necessarily the same matrix as the one in the beginning, since it will also be used in several iterations throughout the algorithm) and a list:

```haskell
eliminate :: [[Float]] -> [Float] -> [[Float]]
eliminate matrix row =
  matrix ++ [foldr subRow row (reverse $ matrix)]
```

This is the step where we iteratively perform the Gaussian elimination between a row in the matrix and all the previous rows (which already went through Gaussian elimination). To see that, note how the fold works here. Given the matrix rows `matrix = [row1, ..., rowN]` and `row`, what we get after applying `eliminate` is ` [row1, ..., rowN, row']`, where `row' = subRow ( ... subRow (subRow row row1) row2 ... ) rowN`; i.e. `row'` is just `row` after we eliminate its $n$ leading coefficients using the $n$ previous rows.

For our desired matrix these iterations should be:

```
*Main> eliminate [[1, 2, 3]] [4, 5, 6]
[[1.0,2.0,3.0],[0.0,-3.0,-6.0]]
*Main> eliminate it [5, 7, 8]
[[1.0,2.0,3.0],[0.0,-3.0,-6.0],[0.0,0.0,-1.0]]
```

Note the use of `it` here to use the first iteration as the input of the next one; in order to Gaussian eliminate the third row we need to use the updated value of the second row. This suggests that the full function for the algorithm should be given by `echelon`:

```haskell
echelon :: [[Float]] -> [[Float]]
echelon matrix =
  foldl eliminate [(head matrix)] (tail matrix)
```

And the result for our example matrix is:

```
*Main> echelon [[1,2,3], [4,5,6], [5,7,8]]
[[1.0,2.0,3.0],[0.0,-3.0,-6.0],[0.0,0.0,-1.0]]
```

We can see that this function works as follows: `row` in `eliminate` is the initial value in `foldl`. More specifically, we take it to be the head of the input matrix, i.e. it's first row. The remaining rows, given by `tail matrix`, are then the second argument `matrix` in `eliminate`. This means that we are implementing

```haskell
foldl eliminate [(head matrix)] (tail matrix)
foldl eliminate row1 [row2, ..., rowN]
row1 `eliminate` row2 `eliminate` ... `eliminate` rowN
```

For our example matrix this would work as:

```haskell
[1, 2, 3] `eliminate` [4, 5, 6]  `eliminate` [5, 7, 8]

( [1, 2, 3] `eliminate` [4, 5, 6] )  `eliminate` [5, 7, 8]

[[1.0,2.0,3.0],[0.0,-3.0,-6.0]] `eliminate` [5, 7, 8]

[[1.0,2.0,3.0],[0.0,-3.0,-6.0],[0.0,0.0,-1.0]]
```
