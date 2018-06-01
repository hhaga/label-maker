module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


---- MODEL ----


type alias Label =
    { name : String
    , percent : String
    , category : String
    , bdt : String
    }


type alias Model =
    { input : Label, output : List Label }


init : ( Model, Cmd Msg )
init =
    ( { input = { name = "", percent = "", category = "", bdt = "" }, output = [] }, Cmd.none )



---- UPDATE ----


type Msg
    = CreateAndShow
    | SetName Label String
    | SetPercent Label String
    | SetCategory Label String
    | SetBdt Label String


genererOutput : Label -> List Label
genererOutput input =
    List.repeat 11 input


calculateSpaces : String -> String
calculateSpaces s =
    String.repeat (6 - (floor ((toFloat (6 + (String.length s)) / 8)))) "\t"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CreateAndShow ->
            ( { model | output = genererOutput model.input }, Cmd.none )

        SetName current value ->
            ( { model | input = { current | name = value } }, Cmd.none )

        SetPercent current value ->
            ( { model | input = { current | percent = value } }, Cmd.none )

        SetCategory current value ->
            ( { model | input = { current | category = value } }, Cmd.none )

        SetBdt current value ->
            ( { model | input = { current | bdt = value } }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ input [ class "input", onInput (SetName model.input), placeholder "navn" ] []
        , input [ class "input", onInput (SetCategory model.input), placeholder "kategori" ] []
        , input [ class "input", onInput (SetPercent model.input), placeholder "prosent" ] []
        , input [ class "input", onInput (SetBdt model.input), placeholder "bdt" ] []
        , button [ class "button", onClick CreateAndShow ] [ text "Generer label" ]
        , textarea [ class "output", cols 90, rows 70 ]
            (List.map
                (\label ->
                    text
                        (String.concat
                            [ "\t"
                            , "Navn: "
                            , label.name
                            , calculateSpaces (label.name)
                            , "Navn: "
                            , label.name
                            , "\t\n\t"
                            , "Kat.: "
                            , label.category
                            , calculateSpaces (label.category)
                            , "Kat.: "
                            , label.category
                            , "\t\n\t"
                            , "Bdt.: "
                            , label.bdt
                            , calculateSpaces (label.bdt)
                            , "Bdt.: "
                            , label.bdt
                            , "\t\n\t"
                            , "Vol.: "
                            , label.percent
                            , calculateSpaces (label.percent)
                            , "Vol.: "
                            , label.percent
                            , "\t\n\n\n"
                            ]
                        )
                )
                model.output
            )
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
