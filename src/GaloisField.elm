module GaloisField (initialize) where

import Array exposing (Array)
import Bitwise exposing (shiftLeft, xor)
import List.Extra

type alias GaloisField = { exponents : Array Int, logarithms : Array Int }


exponentsCount : Int
exponentsCount = 512


logarithmsCount : Int
logarithmsCount = 256


emptyGaloisField : GaloisField
emptyGaloisField =
  { exponents = Array.initialize exponentsCount (always 1)
    , logarithms = Array.initialize logarithmsCount (always 0)
  }


exponentAtIndex : Int -> Int
exponentAtIndex index =
  if index == 0 then
    1
  else if index < (exponentsCount // 2 - 1) then -- 0 < i < 255
    List.foldl (
      \index -> \accumulator ->
        let accumulator = accumulator `shiftLeft` 1 in
          if accumulator >= (exponentsCount // 2) then
            accumulator `Bitwise.xor` 0x11d -- 285
          else
            accumulator
    ) 1 [1..index]
  else -- 255 <= i < 512
    exponentAtIndex (index - (exponentsCount // 2 - 1) )


logarithmAtIndex : List Int -> Int -> Int
logarithmAtIndex exponents index =
  Maybe.withDefault 0 (List.Extra.elemIndex index exponents)


exponents : List Int
exponents =
  List.map (
    exponentAtIndex
  ) [0..(exponentsCount-1)]


logarithms : List Int -> List Int
logarithms exponents =
  List.map (
    logarithmAtIndex exponents
  ) [0..(logarithmsCount-1)]


initialize : GaloisField
initialize =
  let exp = exponents in
    { exponents = Array.fromList exp
      , logarithms = Array.fromList (logarithms exp)
    }

