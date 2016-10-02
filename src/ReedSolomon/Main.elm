module ReedSolomon.Main exposing (main)

import Json.Decode
import Html
import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
import ReedSolomon.Ports


main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { encodeString : String
    , encoded : List Int
    , decodeList : List Int
    , decoded : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" [] [] "", Cmd.none )



-- UPDATE


type Msg
    = ChangeEncode String
    | Encode
    | Encoded (List Int)
    | ChangeDecode String
    | Decode
    | Decoded String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeEncode newString ->
            ( { model | encodeString = newString }, Cmd.none )

        Encode ->
            ( model, ReedSolomon.Ports.encode ( 10, model.encodeString ) )

        Encoded encoded ->
            ( { model | encoded = encoded }, Cmd.none )

        ChangeDecode string ->
            let
                intList =
                    List.map (\v -> Result.withDefault 0 (String.toInt v)) (String.split ", " string)
            in
                ( { model | decodeList = intList }, Cmd.none )

        Decode ->
            ( model, ReedSolomon.Ports.decode ( 10, model.decodeList ) )

        Decoded decoded ->
            ( { model | decoded = decoded }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ ReedSolomon.Ports.encoded Encoded
        , ReedSolomon.Ports.decoded Decoded
        ]



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput ChangeEncode ] []
        , button [ onClick Encode ] [ text "Encode" ]
        , Html.br [] []
        , input [ onInput ChangeDecode ] []
        , button [ onClick Decode ] [ text "Decode" ]
        , div [] [ text (String.join ", " (List.map toString model.encoded)) ]
        , div [] [ text (model.decoded) ]
        ]
