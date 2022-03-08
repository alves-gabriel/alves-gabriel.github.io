# Type classes (feat. Bubble sort)

Here we show an example where type classes can, among many other things, be used to cleverly sort the suits in a deck of cards. Initially we define the suit as a new data type

```haskell
data Suit = Diamond | Spade | Heart | Club
  deriving (Eq, Ord, Enum)
```

from which we would like to derive ```Eq, Ord``` and ```Enum``` typeclasses (this allows us to perform comparisons, ordering and so on). This follows the sorting of the Brazilian card game _Truco_, namely ♦ < ♠ < ♥ < ♣:

 ```
*Main> Club > Diamond
True
*Main> Spade > Heart
False
 ```

How can we construct a sorting algorithm for this data type? A possible approach is the following:

```haskell
-- A single step in Bubble sort
aux_sort :: [Suit] -> [Suit]
aux_sort (x:y:xs)
  | x > y = y : aux_sort (x:xs)
  | otherwise = x : aux_sort (y:xs)
aux_sort (x) = x

-- Full bubble sort algorithm
suit_sort :: [Suit] -> [Suit]
suit_sort lst = if lst == aux_sort lst
  then lst
  else suit_sort $ aux_sort lst
```

In ```aux_sort``` we perform a single iteration of the Bubble sort algorithm. In this step we go through the list once, comparing pair of elements and swapping then if necessary (note how in the first iteration we move the largest element to the end, but the rest of the list remains unsorted):

```
*Main> suit_lst = [Club, Spade, Diamond, Heart]
*Main> aux_sort suit_lst
[♠,♦,♥,♣]
```

 Given that the list is sorted if (and only if) it does not change between two subsequent iterations, then in ```suit_sort``` we can just check (recursively) whether the list changed or not. If the list did not change then the list is already sorted, and we return it. Otherwise, we just further apply another ```aux_sort``` step recursively.

```
*Main> suit_sort suit_lst
[♦,♠,♥,♣]
```
