```Mathematica
CustomRootListed[f_, x0_, nmax_] :=
 NestList[(# - f[#]/f'[#]) &, x0, nmax]
```

```Mathematica
ListAnimate[
 Table[
  Show[
   Plot[g[x], {x, 0, Max@NewtonPath + .25},
    AxesLabel -> {"x", "f(x)"},
    LabelStyle -> {FontSize -> 16, FontFamily -> "Times", Black},
    PlotStyle -> Thick,
    AxesStyle ->
     ConstantArray[{Arrowheads[{0.0, 0.05}], Thickness[.0025]}, 2],
    ImagePadding -> {{20, 20}, {30, 30}},
    Epilog -> {
      Red,
      Arrow@{{NewtonPath[[i]],
         g@NewtonPath[[i]]}, {NewtonPath[[i + 1]], 0}},
      Arrow@{{NewtonPath[[i + 1]], 0}, {NewtonPath[[i + 1]],
         g@NewtonPath[[i + 1]]}}
      }
    ],
   ListPlot[Transpose@{NewtonPath, g /@ NewtonPath},
    PlotMarkers -> Style[\[FilledDiamond], 10, Black]]
   ],
  {i, 1, nmax, 1}
  ]
 ]
```

<p align="center">
  <img src="/assets/images/newton.gif"/>
</p>
