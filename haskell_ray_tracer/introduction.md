# Ray tracing with Haskell

Here I provide some code and some explanations of my very basic implementation of a path tracer. 
I basically follow [the first book](https://raytracing.github.io/books/RayTracingInOneWeekend.html)
of a series on Ray Tracing by Peter Shirley. I am far from proficient in Haskell, so
this post should be seen more as some self-study notes. My implementation is far from efficient
or idiomatic, but I think that maybe I can get the point across and show an intuitive implementation
for other beginners like me. This tutorial is separated into four parts:

## Table of Contents

<div style = "  border-radius: 10px; border-style: solid; border-color: 92a8d1; background: #F0F0F0; padding-top: 20px; width: 350px;  class="left">
    <div style = "width: 350px; " class="center">
        <ul class="sidebar_list">
            <!-- openTab is a .js routine. color:inherit leaves the color of the text unchanged-->
            <!-- The "_cont" flag prevents anchoring movement since the ids are different. Since we want the .js to scroll to the top of the page, not the anchor (which has a weird offset)-->
            <li>
            <a href="#_cont" style="color: inherit;"><b>Introduction</b></a>
            </li><br>
            <li>
            <a href="#partI_cont" style="color: inherit;"><b>Part I - Setting everything up</b></a>
            </li><br>
            <li>
            <a href="#partII_cont" style="color: inherit;"><b>Part II - Shapes</b></a>
            </li><br>
            <li>
            <a href="#partII_cont" style="color: inherit;"><b>Part III - Materials</b></a>
            </li><br>
            <li>
            <a href="#partII_cont" style="color: inherit;"><b>Part IV - Final Scene</b></a>
            </li><br>
            <li>
            <a href="#references_cont" style="color: inherit;"><b>References</b></a>
            </li><br>
        </ul>
    </div>
</div>

## Introduction

### The repository

I have uploaded all the source-code to a [GitHub repo](https://github.com/alves-gabriel/haskell-ray-tracer).
There is also a folder (and a branch) containing the code for each section in this tutorial. So, if 
you want to acess the code at a certain point in the tutorial, just clone the appropriate branch or
check the right folder. In the master branch/main folder you can find the final code with more 
detailed comments.

