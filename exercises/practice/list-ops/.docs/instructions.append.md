# dummy

## Odin-specific instructions

Firstly, some of those operation names collide with builtin procedures.
Some of them are renamed to `my_append`, for example.

Because data in Odin is generally immutable, the `my_append` procedure expects you to return a new list, not add elements to the first list.

You'll notice that there are procs that are expected to receive int slices _or_ f64 slices. 
This is an opportunity to learn about:

* [explicit procedure overloading][groups], and
* [implicit parametric polymorphism][parapoly].

[groups]: https://odin-lang.org/docs/overview/#explicit-procedure-overloading
[parapoly]: https://odin-lang.org/docs/overview/#implicit-parametric-polymorphism
