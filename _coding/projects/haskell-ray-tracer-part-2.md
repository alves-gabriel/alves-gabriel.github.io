---
title: Haskell Ray Tracer, Part II
section: Projects
order: 12
---

<h1 id="Part2Title">
Part II - Geometry
</h1>

## Constructing new shapes

This is the chapter where typeclasses really start to shine for us, just like how classes and methods
work really well in OOP languages. If you are interested, you
can check [this very nice paper](https://dl.acm.org/doi/10.1145/75277.75283) on ad-hoc 
polymorphism. In short, typeclasses are useful when we want certain functions to behave differently
depending on the type of the data they have to operate with. I believe that the motivation is quite 
natural in our case: how a ray scatters will depend both on _the geometry_ of the object and 
_on its composition_, i.e. on its material. A light ray which collides with a sphere will have a
different angle of incidence when hitting a plane. Similarly, the scattering rules for _reflective_
materials will be quite different from the scattering rules for _refractive_ and _diffusive_ objects.
Using typeclasses will aid us in the implementation of a natural solution with very little boilerplate. 
Basically, we can use a small set of functions to handle the optical path of the ray and the coloring
of each pixel, with very little work when adding different materials and geometries. Hopefully this 
will be less abstract in the next few sections.

The remaining geometry notes are still being drafted.
