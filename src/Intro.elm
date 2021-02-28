module Intro exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Process
import Task
import WindowHeader exposing (windowHeader)



-- Data


intro : String
intro =
    """
Starting Introduction script...
.
.
.
Hello, my name is Matheus Anzzulin and I am a Brazilian dev, passionate about functional programming. In my free time, I like to help organize meetups around my area and do some side projects, usually involving tabletop games.
If you want to know more about me or my work here are some useful links:

 """


introLength : Int
introLength =
    String.length intro



-- MODEL


type Model
    = Partial Int
    | Finished


type Msg
    = Writing Int
    | Done


init : ( Model, Cmd Msg )
init =
    ( Partial 0, writeMore 0 )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        Writing length ->
            ( Partial length, writeMore length )

        Done ->
            ( Finished, Cmd.none )


writeMore : Int -> Cmd Msg
writeMore currentLength =
    if introLength > currentLength then
        Process.sleep 10 |> Task.perform (\_ -> Writing (currentLength + 1))

    else
        Process.sleep 1 |> Task.perform (\_ -> Done)



-- View


view : Model -> Html Msg
view model =
    div [ class "terminal" ]
        [ windowHeader "intro.sh"
        , terminalBody model
        ]


terminalBody : Model -> Html Msg
terminalBody model =
    div
        [ class "terminal-body" ]
        (contentView model)


contentView : Model -> List (Html Msg)
contentView model =
    case model of
        Partial length ->
            partialContentView length

        Finished ->
            finishedContentView


partialContentView : Int -> List (Html Msg)
partialContentView length =
    [ div [ class "program-line" ]
        [ span [] [ formatText (String.left length intro) ] ]
    ]


finishedContentView : List (Html Msg)
finishedContentView =
    [ div [ class "program-line" ]
        [ span [] [ formatText intro ]
        , usefulLinksView
        ]
    ]


formatText : String -> Html Msg
formatText value =
    span []
        (List.intersperse
            (br [] [])
            (List.map text (String.lines value))
        )


usefulLinksView : Html Msg
usefulLinksView =
    div [ class "program-line__links" ]
        [ a [ href "https://github.com/Mathitos" ]
            [ text "Github " ]
        , a [ href "https://www.linkedin.com/in/matheusanzzulin/" ]
            [ text "LinkedIn " ]
        ]
