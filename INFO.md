# Information & notes


## Emacs integration

https://github.com/ocaml-community/utop/issues/306

opam config exec -- dune utop . -- -emacs

https://discuss.ocaml.org/t/configuring-a-project-directory-and-setting-up-the-related-toolchain-opam-dune-etc/2635/3

https://github.com/lindig/hello


## Discussion on Discord

damToday at 8:51 PM
Hello,
I'm trying to have a utop repl launched with the dependencies exposed in it.
My basic intent is with the base library.
Here is my dune file:

(executable
 (name main)
 (libraries base))

When I run dune utop . and then open Base;; I have the following response from the toplevel: Line 1, characters 5-9: Error: Unbound module Base
I looked through many pages of documentation but couldn't have it to work.
After that, I'm looking for having this working in Emacs to have a dynamic environment à la Lisp/Clojure (I found this: https://github.com/ocaml-community/utop/issues/306)
I'm freshly arriving to the OCaml world from the Clojure world after finishing the last FUN MOOC session.
Thanks
GitHub
ocaml-community/utop
Universal toplevel for OCaml. Contribute to ocaml-community/utop development by creating an account on GitHub.
Oh I see @anmonteiro here. Thanks for lumo! Very useful.

anmonteiroToday at 9:00 PM
@dam you probably just need to #require "base";;
:wave: thanks

damToday at 9:20 PM
That made it. Thanks.
It also works in Emacs with utop > opam config exec -- dune utop . -- -emacs
A silly question. If I have many dependencies I have to require them all manually? (I must admit that I am used to the Clojure cider-jack-in that loads the dependencies from project.clj and then I can eval a form similar to the open Base phrase without requiring anything)

anmonteiroToday at 9:32 PM
you can write a toplevel file that does that for you
and require that file in the toplevel
damToday at 10:22 PM
Thanks. I'll try that.

## Make merlin work with newly added libraries

Run first `dune build` so that the new library appears in the `_build` folder (if I understoof well (at least the intuition came from https://github.com/ocaml/merlin/issues/388#issuecomment-94406594))
