#lang scribble/doc

@(require (for-label simple-tree-text-markup/data
                     racket/snip racket/draw
		     racket) ; srcloc
          scribble/manual)

@title[#:style 'toc #:tag "simple-tree-text-markup-data"]{Markup Representation}

@defmodule[simple-tree-text-markup/data]

This module defines the representation for markup as a set of struct
definitions.  It should be required when inspecting markup, For
constructing markup, see
@racketmodname[simple-tree-text-markup/construct].

A markup object can be one of the following:

@itemize[
@item{a string}
@item{an @racket[empty-markup]}
@item{a @racket[horizontal-markup]}
@item{a @racket[vertical-markup]}
@item{a @racket[srcloc-markup]}
@item{a @racket[framed-markup]}
@item{an @racket[image-markup]}]

@defproc[(markup? [object any/c]) boolean?]{
Returns @racket[#t] if @racket[object] is a markup object, @racket[#f] otherwise.
}

@defstruct*[empty-markup ()]{
This is an empty markup object, which consumes no space.}

@defstruct*[horizontal-markup
	    ((markups (listof markup?)))]{
This markup object contains several sub-markups, which will be
arranged horizontally when rendered.
}

@defstruct*[vertical-markup
	    ((markups (listof markup?)))]{
This markup object contains several sub-markups, which will be
arranged vertically when rendered.
}

@defstruct*[srcloc-markup
	    ((srcloc srcloc?)
             (markup markup?))]{
This markup object represents a link to a source location, represented
by @racket[srcloc], where the link visualization is represented by
@racket[markup].
}

@defstruct*[framed-markup
	    ((markup markup?))]{
This markup object puts a frame around @racket[markup].
}

@defstruct*[image-markup
	   ((data any/c)
	    (alt-markup markup?)
	    (width (or/c #f natural-number/c))
            (height (or/c #f natural-number/c)))]{
This markup object represents an image.  The @racket[data] contains the image data.
The format is not exactly specified, but a graphical renderer should accept
@racket[bitmap%] and @racket[snip%] objects and the datum from a @racket[record-dc%].

The @racket[width] and @racket[height] are for image data that doesn't specify width
and height - notably the datum from a @racket[record-dc%].

If rendering of @racket[data] is not possible, @racket[alt-markup] can be substituted.
}
