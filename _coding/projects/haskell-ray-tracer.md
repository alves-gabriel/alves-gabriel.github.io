---
title: Haskell Ray Tracer
section: Projects
order: 10
---

Here I provide some code and some explanations of my very basic implementation of a path tracer. 
I basically follow [the first book](https://raytracing.github.io/books/RayTracingInOneWeekend.html)
of a series on Ray Tracing by Peter Shirley. I am far from proficient in Haskell, so
this post should be seen more as some self-study notes. My implementation is far from efficient
or idiomatic, but I think that maybe I can get the point across and show an intuitive implementation
for other beginners like me. This tutorial is separated into four parts:

## Table of Contents

<nav class="tutorial-toc" aria-label="Haskell ray tracer table of contents">
  <ol>
    <li><a href="/coding/projects/haskell-ray-tracer/">Introduction</a></li>
    <li><a href="/coding/projects/haskell-ray-tracer-part-1/">Part I - Setting everything up</a></li>
    <li><a href="/coding/projects/haskell-ray-tracer-part-2/">Part II - Shapes</a></li>
    <li>Part III - Materials</li>
    <li>Part IV - Final Scene</li>
    <li><a href="/coding/projects/haskell-ray-tracer-references/">References</a></li>
  </ol>
</nav>

## Introduction

### The repository

I have uploaded all the source-code to a [GitHub repo](https://github.com/alves-gabriel/haskell-ray-tracer).
There is also a folder (and a branch) containing the code for each section in this tutorial. So, if 
you want to acess the code at a certain point in the tutorial, just clone the appropriate branch or
check the right folder. In the master branch/main folder you can find the final code with more 
detailed comments.
