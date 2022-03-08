# Record syntax

Records are particularly useful when we intend to use data types whose value constructors contain several fields. Let's start by creating a data type called ```Point```, which can be either two or three-dimensional:

```Haskell
data Point =
     TwoD { x0 :: Float, y0 :: Float}
   | ThreeD { x1 :: Float, y1 :: Float, z1 :: Float}
```

Note the use of curly brackets here. It's also desirable to give different names to the fields inside the brackets. Checking the type of both the value constructors and its fields will give us some hints on how they should be used:

```
*Main> :t x0
x0 :: Point -> Float
*Main> :t TwoD
TwoD :: Float -> Float -> Point
```
We can for instance, write

```
*Main> x0 TwoD {x0 = 1, y0 = 2.5}
1.0
```

to recover the fields. Calling the point itself however has no effects. It actually raises an error:

```
*Main> TwoD {x0 = 1, y0 = 2.5}

<interactive>:12:1: error:
    • No instance for (Show Point) arising from a use of ‘print’
    • In a stmt of an interactive GHCi command: print it
```

If we establish an instance for show, so the function works with this data type,

```Haskell
instance Show Point where
  show (TwoD x0 y0) = "(x = " ++ (show $ x0) ++ ", y = " ++ (show $ y0) ++ ")"
  show (ThreeD x1 y1 z1) = "(x = " ++ (show $ x1) ++ ", y = " ++ (show $ y1) ++ ", z = " ++ (show $ z1) ++ ")"
```

we get:

```
*Main> TwoD {x0 = 1, y0 = 2.5}
(x = 1.0, y = 2.5)
```

We can also construct functions which have ```Point``` types as an input. We can also conveniently ignore the irrelevant parameters on functions which do not require all of them. In the following example we apply this to a cartesian-spherical coordinates conversion (see the function ```theta```):

```haskell
radius :: Point -> Float
radius (ThreeD x y z) = sqrt(x**2 + y**2 + z**2)

theta :: Point -> Float
theta (ThreeD x y _) = atan (y/x)

phi :: Point -> Float
phi (ThreeD x y z) = acos (z/ radius (ThreeD x y z))
```

For instance:

```
*Main> let coordinate1 = ThreeD {x1 = 0, y1 = -1, z1 = 3}
*Main> radius coordinate1
3.1622777
*Main> theta coordinate1
-1.5707964
```

We may also define binary operations between points, which can yield another `Point` type, a `Float` type or any other sensible data type.

```haskell
vecAdd :: Point -> Point -> Point
vecAdd (ThreeD c0 c1 c2) (ThreeD c0' c1' c2') = ThreeD {x1 = c0 + c0', y1 = c1 + c1', z1 = c2 + c2'}

dotProd :: Point -> Point -> Float
dotProd (ThreeD c0 c1 c2) (ThreeD c0' c1' c2') = c0*c0' + c1*c1' + c2*c2'
```

Example usage:

```
*Main> let coordinate1 = ThreeD {x1 = 0, y1 = -1, z1 = 3}
*Main> let coordinate2 = ThreeD {x1 = 1, y1 =  1, z1 = 2}
*Main> coordinate1 `vecAdd` coordinate2
(x = 1.0, y = 0.0, z = 5.0)
*Main> coordinate1 `dotProd` coordinate2
5.0
```

Finally, we define a new data type called `Geometrical`. Here we do not use
the record syntax, in order to highlight their difference. We also define a new function for
constructing a rectangle given two points: by feeding the lower left and upper right
corners of the rectangle as `Points` we get its width and height. Finally,
we construct a function which calculates the area of the given rectangle:

```haskell
data Geometrical =
     Rectangle Float Float
   | Ellipse Float Float Float Float deriving (Show)

pointsToRec :: Point -> Point -> Geometrical
pointsToRec (TwoD c0 c1) (TwoD c0' c1') = Rectangle (c0' - c0) (c1' - c1)

recArea :: Geometrical -> Float
recArea (Rectangle width height) = width * height
```

Note that we use `deriving (Show)` here in order to avoid the need of manually handling the printing of this data type. These functions can be called in the following manner:

```
*Main> let corner1 = TwoD {x0 = 0, y0 = 0}
*Main> let corner2 = TwoD {x0 = 2, y0 = 5}
*Main> rectangle1 = pointsToRec corner1 corner2
*Main> rectangle1
Rectangle 2.0 5.0
*Main> recArea rectangle1
10.0
```
