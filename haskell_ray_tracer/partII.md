<h1 id="Part2Title">
Part II - Geometry
</h1>

## Construcing new shapes 

This is the chapter where typeclasses really start to shine for us, just like how classes and methods
works really well in OOP languages. If you are interested, you
can check [this very nice paper](https://dl.acm.org/doi/10.1145/75277.75283) on ad-hoc 
polymorphism. In short, we typeclasses are useful when we want certain functions to behave differently
depending on the type of the data they have to operate with. I believe that the motivation is quite 
natural in our case: how a ray scatter will depend both on _the geometry_ of the object and 
_on its composition_, i.e. on its material. A light ray which collides with a sphere will have a
different angle of incidence when hitting a plane. Similarly, the scattering rules for _reflective_
materials will be quite different from the scattering rules for _refractive_ and _diffusive_ objects.
Using typeclasses will aid us in the implementation of a natural solution with very little boilerplate. 
Basically, we can use a small set of functions to handle the optical path of the ray and the coloring
of each pixel, with very little work when adding different materials and geometries. Hopefully this 
will be less abrasct in the next few sections. 


Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vel congue ante. Donec nec consectetur ante. Phasellus commodo orci eget odio tempus, quis vestibulum nulla vulputate. Maecenas non enim ex. Etiam consequat purus massa, id sollicitudin mi mollis nec. Aliquam luctus tincidunt enim, vitae faucibus magna pretium quis. Integer id dui ac sapien fringilla porta. Vivamus fermentum enim libero. Nunc nec luctus nibh, in venenatis nunc.

Ut tellus mauris, tristique et metus eu, bibendum mollis mauris. Aliquam ut ultrices libero, vel eleifend est. Aliquam pulvinar volutpat dignissim. Aenean et nulla nec diam dignissim consectetur. Ut vehicula sem a tortor finibus, eget hendrerit eros eleifend. Mauris sit amet scelerisque ipsum, a suscipit leo. Mauris pretium elementum lacus, at efficitur velit convallis a. Quisque efficitur aliquam velit, a mattis ex scelerisque vel. Nullam eget enim commodo, facilisis nunc a, hendrerit ex. Vestibulum feugiat imperdiet libero, non aliquet turpis eleifend nec. Sed egestas volutpat odio mollis faucibus. Nulla eget odio vel mi condimentum suscipit porttitor eu risus. Suspendisse auctor tempor turpis, in lacinia diam iaculis id.

Etiam nisl diam, mattis a quam at, varius feugiat erat. Maecenas semper ante ante, et egestas ex rhoncus sed. Sed viverra arcu ac consectetur volutpat. Curabitur velit nunc, hendrerit sed odio eu, tempor commodo est. Maecenas sagittis neque sit amet lorem ultricies elementum. Fusce dictum lorem ac odio tincidunt, nec sodales elit pulvinar. In hac habitasse platea dictumst. Curabitur sollicitudin aliquam rhoncus. Sed ipsum ligula, interdum sed ultricies sed, ornare fermentum urna. Donec in vulputate neque. Maecenas mi sem, tempus at ultrices at, viverra in turpis. Sed lacinia elementum diam id gravida. Nullam non diam purus.

Nunc ex orci, congue ac purus sit amet, vestibulum dapibus neque. Etiam imperdiet ipsum massa, at cursus nulla consectetur quis. Morbi vestibulum ornare aliquet. Integer nulla quam, feugiat eu aliquet et, bibendum vel erat. Nullam porttitor feugiat sapien, nec tincidunt sem blandit vel. In egestas ante leo, ullamcorper convallis magna finibus eu. Curabitur consectetur diam sed porta fringilla. Nam ullamcorper dui ac quam tempor, sit amet congue nisl porta. Quisque sed interdum libero, quis suscipit sem. Aliquam erat volutpat. Mauris ut dolor sagittis ante interdum interdum.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eget fringilla massa, a ullamcorper erat. Cras orci dui, vehicula at lobortis a, fermentum tincidunt odio. Etiam eget lorem egestas, maximus metus eget, iaculis erat. Praesent non dolor lacus. In sit amet lacus sed dolor mattis facilisis id et ante. Morbi id arcu sit amet nisi lacinia luctus sit amet at mauris. Sed id leo a ante consectetur ornare. Phasellus vestibulum nulla nec turpis tempor congue. Aliquam tincidunt lobortis elit, ac tempor est lacinia sit amet. Aenean viverra, leo et luctus vulputate, nibh mi dignissim erat, vitae suscipit mauris ante eu augue. Quisque sed enim vitae nulla tristique viverra eget ut ipsum. Aliquam erat volutpat. Phasellus at ipsum quis massa porta gravida in at diam.