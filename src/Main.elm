module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


---- MODEL ----


type alias Label =
    { name : String
    , percent : String
    , category : String
    , batchnumber : String
    , ibu : String
    , brewdate : String
    }


type alias Model =
    { input : Label, output : List Label }


init : ( Model, Cmd Msg )
init =
    ( { input = { name = "", percent = "", category = "", batchnumber = "", ibu = "", brewdate = "" }, output = [] }, Cmd.none )



---- UPDATE ----


type Msg
    = CreateAndShow
    | SetName Label String
    | SetPercent Label String
    | SetCategory Label String
    | SetBatchNumber Label String
    | SetIbu Label String
    | SetBrewdate Label String


genererOutput : Label -> List Label
genererOutput input =
    List.repeat 11 input


calculateSpaces : String -> String
calculateSpaces s =
    String.repeat (5 - (floor ((toFloat (String.length s) / 8)))) "\t"


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

        SetBatchNumber current value ->
            ( { model | input = { current | batchnumber = value } }, Cmd.none )

        SetIbu current value ->
            ( { model | input = { current | ibu = value } }, Cmd.none )

        SetBrewdate current value ->
            ( { model | input = { current | brewdate = value } }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ div [ class "form" ]
            [ input [ class "input", onInput (SetName model.input), placeholder "navn" ] []
            , input [ class "input", onInput (SetCategory model.input), placeholder "kategori" ] []
            , input [ class "input", onInput (SetBatchNumber model.input), placeholder "batch" ] []
            , input [ class "input", onInput (SetPercent model.input), placeholder "prosent" ] []
            , input [ class "input", onInput (SetIbu model.input), placeholder "ibu" ] []
            , input [ class "input", onInput (SetBrewdate model.input), placeholder "bryggedato" ] []
            , button [ class "button", onClick CreateAndShow ] [ text "Generer label" ]
            ]
        , div []
            [ textarea [ class "output", cols 90, rows 70 ]
                (List.map
                    (\label ->
                        text
                            (String.concat
                                [ "\t"
                                , "Navn  : "
                                , label.name
                                , calculateSpaces (label.name)
                                , "Navn  : "
                                , label.name
                                , "\n\t"
                                , "Kat.  : "
                                , label.category
                                , calculateSpaces (label.category)
                                , "Kat.  : "
                                , label.category
                                , "\n\t"
                                , "Dato  : "
                                , label.brewdate
                                , calculateSpaces (label.brewdate)
                                , "Dato  : "
                                , label.brewdate
                                , "\n\t"
                                , "Batch : "
                                , label.batchnumber
                                , calculateSpaces (label.batchnumber)
                                , "Batch : "
                                , label.batchnumber
                                , "\n\t"
                                , "Ibu   : "
                                , label.ibu
                                , calculateSpaces (label.ibu)
                                , "Ibu   : "
                                , label.ibu
                                , "\n\t"
                                , "Vol.  : "
                                , label.percent
                                , calculateSpaces (label.percent)
                                , "Vol.  : "
                                , label.percent
                                , "\n\n\n"
                                ]
                            )
                    )
                    model.output
                )
            ]
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
