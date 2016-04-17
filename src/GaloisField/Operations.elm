module GaloisField.Operations (multiply, divide) where

import Array

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
