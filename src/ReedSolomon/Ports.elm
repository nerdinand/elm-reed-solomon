port module ReedSolomon.Ports exposing (..)

-- Outgoing


port encode : ( Int, String ) -> Cmd msg


port decode : ( Int, List Int ) -> Cmd msg



-- Incoming


port encoded : (List Int -> msg) -> Sub msg


port decoded : (String -> msg) -> Sub msg
