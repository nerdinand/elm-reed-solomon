# elm-reed-solomon
Eventually, this might become a Reed-solomon error correction library written in Elm.

This is a prerequisite for my other project, [a QR code library written in Elm](https://github.com/nerdinand/elm-qr-code).
At the moment I'm mainly interested in getting the message encoding implemented, since that's what's needed for QR code generation. Further down the road I might also implement message decoding.
I started this as a project to teach myself the wonderful Elm programming language.
It's my first functional language (not counting Javascript), so the code might be awful.

Nevertheless, you're welcome to join me in my endeavour.

## Implemented

* Galois Field
  * initalisation
  * multiplication
  * division
  * polyScale

## To do

* Functions on the Galois Field:
  * polyAdd
  * polyMul
  * polyEval
* Reed-Solomon coding
  * message encoding

## Further to do

* Reed-Solomon coding
  * message decoding
