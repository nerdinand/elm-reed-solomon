module GaloisField.Operations exposing (multiply, divide, polyScale, polyAdd)

import Array
import Bitwise exposing (xor)

import GaloisField


getLogarithm : GaloisField.GaloisField -> Int -> Maybe Int
getLogarithm galoisField index =
  Array.get index galoisField.logarithms


multiply : GaloisField.GaloisField -> Int -> Int -> Maybe Int
multiply galoisField x y =
  if x == 0 || y == 0 then
    Just 0
  else if x < 0 || y < 0 then
    Nothing
  else
    let
      logx = getLogarithm galoisField x
      logy = getLogarithm galoisField y
    in
      Maybe.map2 ( \logx -> \logy ->
        Maybe.withDefault 0 {- not gonna happen -} (
          Array.get (logx + logy) galoisField.exponents
        )
      ) logx logy


divide : GaloisField.GaloisField -> Int -> Int -> Maybe Int
divide galoisField x y =
  if y == 0 then
    Nothing
  else if x == 0 then
    Just 0
  else if x < 0 || y < 0 then
    Nothing
  else
    let
      logx = getLogarithm galoisField x
      logy = getLogarithm galoisField y
    in
      Maybe.map2 ( \logx -> \logy ->
        Maybe.withDefault 0 {- not gonna happen -} (
          Array.get (logx + ((Array.length galoisField.logarithms) - 1) - logy) galoisField.exponents
        )
      ) logx logy


polyScale : GaloisField.GaloisField -> List Int -> Int -> List (Maybe Int)
polyScale galoisField polynome x =
  List.map ( \y ->
    multiply galoisField y x
  ) polynome

polyAdd : GaloisField.GaloisField -> List Int -> List Int -> List Int
polyAdd galoisField polynome1 polynome2 =
  let
    polynome1Length = List.length polynome1
    polynome2Length = List.length polynome2
    maximumLength = List.maximum [polynome1Length, polynome2Length]
    polynome1Array = Array.fromList polynome1
    polynome2Array = Array.fromList polynome2
  in
    let
      intermediate = Array.fromList(
        List.map ( \index ->
          Maybe.withDefault 0 (Array.get index polynome1Array)
        ) [0..(polynome1Length - 1)])
    in
      [1]
