# Foldr examples

### Multiplying two number using (+)

Multiplication between two numbers n and m can (only for the sake of the example, of course) be very naturally implemented with ```foldr```. We can i) build a function which constructs an array with m copies of a number n and ii) apply foldr and the (+) operator to this array.

```none
Prelude> let mcopy m n | m < 0 = [] | otherwise = n:mcopy (m-1) n
Prelude> mult m n = foldr (+) 0 (mcopy m n)
Prelude> mcopy 5 2
[2,2,2,2,2,2]
Prelude> mult 5 2
12
```

Note how the list is constructed _recursively_. This is is implemented through the function  ```mcopy```, whose first argument is the index of the list (to keep track of how many copies should be made), so we can call it recursively until the index reaches 0. Meanwhile the second argument is just the number being copied. ```foldr``` is then used to apply the (+) operators to this list, effectively performing the sum
<p align="center">
<img src="http://latex.codecogs.com/svg.latex?n&space;\times&space;m&space;=&space;\underbrace{n&plus;...&plus;&space;n}_{\text{m&space;times}}" title="http://latex.codecogs.com/svg.latex?n \times m = \underbrace{n+...+ n}_{\text{m times}}" />
</p>

m times.

### Using foldl and foldr to reverse a list

This example somewhat highlights the difference between ```foldl``` and ```foldr```. Let's take the list [1, 2, 3, 4] as an example. Note that the reversed list can be written as:

```none
Prelude> 4:3:2:1:[]
[4,3,2,1]
```

This suggests a binary operation ```x_rest ⊕ x = x:x_rest```, which has type signature ```[a] -> a -> [a]```. For instance, if we perform ```[1,2]⊕3```, we get ```[1,2]⊕3 = 3:[1,2] = [3,1,2]```. Note how this would work with ```foldl```, with evaluation from left to the right:

```haskell
foldl (⊕) a [x1,...,xn] = a ⊕ x1 ⊕ ... ⊕ xn
```

so, defining the binary operation

```haskell
⊕ = (\x_rest x -> x : x_rest)
```

we get the reversed list:

```haskell
foldl ⊕ [1, 2, 3, 4] []
= [] ⊕ 1 ⊕ 2 ⊕ 3 ⊕ 4              
= ( 1:[] ) ⊕ 2 ⊕ 3 ⊕ 4
= [1] ⊕ 2 ⊕ 3 ⊕ 4
= ( 2 : [1]) ⊕ 3 ⊕ 4
= [2, 1] ⊕ 3 ⊕ 4
= ( 3 : [2, 1]) ⊕ 4
= [3, 2, 1]  ⊕ 4
= 4:[3, 2, 1]
= [4, 3, 2, 1]
```

Concretely:


```
*Main> rev = foldl (\x_rest x -> x : x_rest) []
*Main> rev [1,2,3,4]
[4,3,2,1]
*Main> rev_alt = foldr (\x_rest x -> x++[x_rest]) []
*Main> rev_alt [1,2,3,4]
[4,3,2,1]
*Main> rev_alt2 = foldr (\x x_rest -> x:x_rest) []
*Main> rev_alt2 [1,2,3,4]
[1,2,3,4] -- Wrong!
```

In order to use ```foldr``` we may use the append operator ```+++``` instead as shown above.
