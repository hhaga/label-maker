module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


---- MODEL ----


type alias Label =
    { name : String
    , percent : String
    , category : String
    }


type alias Model =
    { input : Label, output : List Label }


init : ( Model, Cmd Msg )
init =
    ( { input = { name = "", percent = "", category = "" }, output = [] }, Cmd.none )



---- UPDATE ----


type Msg
    = CreateAndShow
    | SetName Label String
    | SetPercent Label String
    | SetCategory Label String


genererOutput : Label -> List Label
genererOutput input =
    List.repeat 15 input


calculateSpaces : String -> String
calculateSpaces s =
    String.repeat ((45 - (6 + String.length s)) // 2) " "


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



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ input [ class "input", onInput (SetName model.input), placeholder "navn" ] []
        , input [ class "input", onInput (SetCategory model.input), placeholder "kategori" ] []
        , input [ class "input", onInput (SetPercent model.input), placeholder "prosent" ] []
        , button [ class "button", onClick CreateAndShow ] [ text "Generer label" ]
        , textarea [ class "output", cols 90, rows 80 ]
            (List.map
                (\label ->
                    text
                        (String.concat
                            [ calculateSpaces (label.name)
                            , "Navn: "
                            , label.name
                            , calculateSpaces (label.name)
                            , calculateSpaces (label.name)
                            , "Navn: "
                            , label.name
                            , calculateSpaces (label.name)
                            , "\n"
                            , calculateSpaces (label.category)
                            , "Kat.: "
                            , label.category
                            , calculateSpaces (label.category)
                            , calculateSpaces (label.category)
                            , "Kat.: "
                            , label.category
                            , calculateSpaces (label.category)
                            , "\n"
                            , calculateSpaces (label.category)
                            , "Bdt.: "
                            , label.category
                            , calculateSpaces (label.category)
                            , calculateSpaces (label.category)
                            , "Bdt.: "
                            , label.category
                            , calculateSpaces (label.category)
                            , "\n"
                            , calculateSpaces (label.percent)
                            , "Vol.: "
                            , label.percent
                            , calculateSpaces (label.percent)
                            , calculateSpaces (label.percent)
                            , "Vol.: "
                            , label.percent
                            , calculateSpaces (label.percent)
                            , "\n\n\n"
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
