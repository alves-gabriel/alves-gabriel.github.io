# Josephus problem

Here we show how _Mathematica_, together with functional programming, can provide a very concise solution to [Josephus problem](https://en.wikipedia.org/wiki/Josephus_problem):

> Consider n people lined up. The first person in front of the line is moved to its end. Meanwhile, the second person is removed from the line. The third person is then moved to the end of the line and so on until a single person remains. What is the position of the remaining person in the original line?

We can begin by creating an operation called `JosephusOperator` which performs two actions:

1. Moves the first element to the end of the list
2. Deletes the new first element (former second element)

The former can be implemented simply by using `RotateLeft`, e.g. `RotateLeft[{a, b, c}, 1] = {b, c, a}`, while the latter can be implemented simply through `Delete[L, 1]`. Thus, the action of `JosephusOperator` would be  `JosephusOperator[{1, 2, 3, 4, 5}] = {3, 4, 5, 1}`. Finally, we just have to repeatedly apply the operator `JosephusOperator`, i.e.  `JosephusOperator[JosephusOperator[...]]` up to the point where the list has only a a single element. The operator can be written as:

```Mathematica
JosephusOperator[queue_] := Delete[RotateLeft[queue, 1], 1]
```

And the nesting operation can be constructed by using `NestWhile`:

```Mathematica
JosephusRemaining[n_] := First@NestWhile[JosephusOperator, Range[n], Length[#] > 1 &]
```

The implementation above continuously apply the operator until the list reaches length 1. Plotting the results we get:

```Mathematica
ListPlot[
 Table[JosephusRemaining[n], {n, 1, nmax = 200}]
 , Frame -> True
 , FrameLabel -> {"Queue size n", "Remaining person"}
 , LabelStyle -> {FontSize -> 16, FontFamily -> "Times", Black}
 , PlotRangePadding -> 0
 ]
```

<p align="center">
  <img src="/assets/images/josephus.png"/>
</p>

We can explicitly check how the queue evolves  (`NestWhileList` stores all the intermediate lists):

```
Print @@@ NestWhileList[JosephusOperator, Range[5], Length[#] > 1 &];

12345
3451
513
35
3
```

The alternative solution using fixed point could be implemented, for instance, as:

```Mathematica
JosephusOperatorII[queue_] := Delete[RotateLeft[queue, 1], 1] /; Length[queue] > 1
JosephusOperatorII[queue_] := queue /; Length[queue] <= 1
```

And we can just call

```Mathematica
First@FixedPoint[JosephusOperatorII, Range[5]] (*Outputs 3*)
```

Here we just had to implement an extra condition to handle the special case when the list contains a single element (so we just have to return the list itself).

---

Notebook <a href="assets/notebooks/Josephus.nb">here<a>.
