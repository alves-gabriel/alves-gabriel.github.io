-- # Exercise 
--
-- Construct a function which receives a set of k data points (xk, yk) and a point x
-- and returns L(x), the interpolated Lagrangian polynomial at x:
-- https://en.wikipedia.org/wiki/Lagrange_polynomial
--
-- Test case:
-- f = lagrange [(1.0, 1.0), (2.0, 4.0), (3.0, 9.0)]
-- f 5.0 => 25.0
--
-- The strategy here is to first use a fold for lj(x) and then another one for the sum in L(x).
--
-- Fold is a natural way to construct summations and products of several terms, so. For the products
-- (x - xm)/(xj - xm) for j!=m we can use foldr. Note that this can be written as:
--
-- (x - x0)/(xj - x0)...(x - xn)/(xj - xn) x 1, so since foldr (⊕) a [x1,...,xn] = x1 ⊕ ... ⊕ xn ⊕ a
-- it's not hard to identify the initial value for the accumulator as a = 1.
-- Now, regarding the binary operation (⊕), note that if we have
--
-- x1 ⊕ ... xm ⊕ acc
--
-- It's possible to identify the accumulator acc as all the products to the right of xm, so
-- acc = (x - x(m+1))/(xj - x(m+1))...(x - xn)/(xj - xn)
-- so what the binary operation should do is:
--
-- xm ⊕ acc = (x - xm)/(xj - xm) * acc
--
-- we just construct the m-th term in the product as  (x - xm)/(xj - xm), as long xm != xj and then
-- multiply it by all the previous products, which are contained within acc. Note the use of pattern
-- matching in the implementation. We do \(xm, _) acc  when defining the anonymous function.
-- If xj = xm then we want to do nothing. The proper way to do this then is to return the accumulator
-- itself, i.e.
--
-- xm ⊕ acc = acc, for xj = xm
--
-- The reasoning is quite similar for the summation. But in this case a = 0, and instead of multiplying
-- by the accumulator we simply sum. So
--
-- (xj, yj) ⊕ acc = yj*l_j(x) + acc

-- lj xj xy_lst x :
--  Returns the value l_j(x), i.e. the j-th term in the lagrangian polynomial
--
-- xy_lst : tuples [(x, y)] of points
-- x: point x to be evaluated
-- xj: x values of the j-th point in the tuples
lj :: Float -> [(Float, Float)] -> Float -> Float
lj xj xy_lst x = foldr (\(xm, _) acc -> if xm /= xj then ((x - xm)/(xj - xm))*acc else acc) 1.0 xy_lst

lagrange :: [(Float, Float)] -> Float -> Float
lagrange xy_lst x = foldr (\(xj, yj) acc ->  yj*(lj xj xy_lst x) + acc) 0.0 xy_lst
