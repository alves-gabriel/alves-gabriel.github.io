```Mathematica
JosephusOperator[queue_] := Block[{temp = queue},
Delete[RotateLeft[temp, 1], 1]
]
```

```Mathematica
JosephusRemaining[n_] :=
 First@NestWhile[JosephusOperator, Range[n], Length[#] > 1 &]

 ListPlot[Table[JosephusRemaining[n], {n, 1, nmax = 200}],
Frame -> True,
FrameLabel -> {"Queue size n", "Remaining person"},
LabelStyle -> {FontSize -> 16, FontFamily -> "Times", Black},
PlotRangePadding -> 0
]
```

<p align="center">
  <img src="/assets/images/josephus.png"/>
</p>

```Mathematica
JosephusOperatorII[queue_] :=
Block[{temp = queue},
 Delete[RotateLeft[temp, 1], 1] /; Length[queue] > 1]

JosephusOperatorII[queue_] := queue /; Length[queue] <= 1

First@FixedPoint[JosephusOperatorII, Range[200]]
```
