Ignore mouse inputs in emacs
============================

It's possible to disable mouse bindings in emacs, either with `keymap-set` by
hand, or just by using a package like [disable-mouse][dm]. Unfortunately, mouse
input events are still sent to emacs, they just aren't bound to anything. As a
result, you intend to type `C-c C-x j`, but you bump your laptop's touchpad and
emacs complains that `C-c C-x <wheel-down>` is not bound.

Instead, we ignore these at the `input-decode-map` level. This seems to work.
However, I've barely tested it, and core emacs maintainers made ominous warnings
about "ghost events" and possible undesirable effects on `while-no-input`. Does
this matter? I have no idea! Caveat emptor.

Installation
------------

Hopefully this will be on [MELPA][m] before anyone finds it.

You can also install it manually if you're some kind of psychopath, but I won't
be providing instructions since I don't support that kind of degeneracy.

Usage
-----

```
(ignore-mouse-global-mode +1)
```

[dm]: https://github.com/purcell/disable-mouse
[m]: https://melpa.org/
