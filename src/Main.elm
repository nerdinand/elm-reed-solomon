module Main exposing (main)

import Html

function : List Int -> List Int -> Int
function a b =
  let
    polynome1Length = List.length a
    polynome2Length = List.length b
    maximumLength = Maybe.withDefault 0 (List.maximum [polynome1Length, polynome2Length])
  in
    maximumLength


main : Html.Html String
main =
  Html.text (toString (function [1,2,3] [5,6,7,8,9]))
