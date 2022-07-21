# Lagrange polynomials in Haskell using fold

We are going to implement [Lagrange polynomials](!https://en.wikipedia.org/wiki/Lagrange_polynomial) in Haskell. In other words, we will write a function which receives a set of $k$ data points $(x_k, y_k)$ and returns the interpolated function $L(x)$ for a given point $x$. The strategy here is to first use a ```fold``` for each term of the type

$$
\ell_j(x) 
= 
\frac{(x-x_0)}{(x_j-x_0)} \cdots \frac{(x-x_{j-1})}{(x_j-x_{j - 1})} \frac{(x-x_{j+1})}{(x_j-x_{j+1})} \cdots \frac{(x-x_k)}{(x_j-x_k)} 
= 
\prod_{\begin{smallmatrix} 0\le m\le k \\\\  m\neq j\end{smallmatrix}} \frac{x-x_m}{x_j-x_m}.
$$

This term interpolates $x_j$, since $\ell_j(x_j) = 1$ and $\ell_j(x_m) = 0$ for $m = 0,..., k$ and $m \neq j$. Afterwards, we will also need to implement $L(x)$:

$$
L(x) = \sum_{j=0}^{k} y_j \ell_j(x).
$$

This can also be done using ```fold```. For the first equation, the following code snippet should work:

```haskell
lj :: Float -> [(Float, Float)] -> Float -> Float
lj xj xy_lst x = foldr (\(xm, _) acc -> if xm /= xj then ((x - xm)/(xj - xm))*acc else acc) 1.0 xy_lst
```

This function receives three paramenters as arguments: the point $x_j$, denoted by ```xj```, the tuples $(x_k, y_k)$ given by ```xy_lst``` and finally the evaluation point ```x```. Our strategy here is simply to use ```fold``` to succesively construct each fraction of the form:

$$
\frac{x-x_m}{x_j-x_m}
$$

and then multiply it by the accumulator, constructing the productory.  This is achieved in a very simple way: by using a pattern matching in the tuples we can get the points $x_m$. This is then used to construct an anonymous function which verifies whether $x_m \neq x_j$. If true, we can then write the fraction above and multiply it by the accumulator, i.e. ```((x - xm)/(xj - xm))*acc```, otherwise we do nothing and simply return the accumulator ```acc``` itself. One way to think about this is to notice that the accumulator should contain the product of all terms with index larger than $m$ (or smaller, if you used ```foldl```), in other words, at the $m$-th step the accumulator should read:

$$
acc
=
\frac{(x-x_{m+1})}{(x_j-x_{m+1})} \frac{(x-x_{m+2})}{(x_j-x_{m+2})} \cdots \frac{(x-x_{k})}{(x_j-x_{k})}
$$

Note that since we are working with a productory, the accumulator should initially be $1$. Finally, we implement the summation. The reasoning here is analogous, this time however the accumulator refers to the sum of all the previous terms (instead of their product), and it should start at $0$. We can write something like:
 
```haskell
lagrange :: [(Float, Float)] -> Float -> Float
lagrange xy_lst x = foldr (\(xj, yj) acc ->  yj*(lj xj xy_lst x) + acc) 0.0 xy_lst
```

As a test case we have:

```shell
Prelude > f = lagrange [(1.0, 1.0), (2.0, 8.0), (3.0, 20.0)] 
Prelude > f 4 
37.0
Prelude > f 5 
59.0
``` 

This post was based on [this exercise](!https://www.youtube.com/watch?v=46dksIrx6jQ).