module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (..)
import Intro



-- MAIN


main : Program () Model Msg
main =
    Browser.element { init = \_ -> initialModel, update = update, view = view, subscriptions = \_ -> Sub.none }



-- MODEL


type Window
    = Intro
    | Picture


type alias Model =
    { windowsOrder : List Window, openWindows : List Window, introModel : Intro.Model }


initialModel : ( Model, Cmd Msg )
initialModel =
    let
        ( newIntroModel, cmd ) =
            Intro.init
    in
    ( { windowsOrder = [ Intro, Picture ]
      , openWindows = [ Intro, Picture ]
      , introModel = newIntroModel
      }
    , Cmd.map IntroMsg cmd
    )



-- UPDATE


type Msg
    = ChangeWindow Window
    | CloseWindow Window
    | OpenWindow Window
    | IntroMsg Intro.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeWindow window ->
            ( changeWindowFocus window model, Cmd.none )

        CloseWindow window ->
            ( closeWindow window model, Cmd.none )

        OpenWindow window ->
            ( openWindow window model, Cmd.none )

        IntroMsg introMsg ->
            let
                ( newIntroModel, cmd ) =
                    Intro.update introMsg model.introModel
            in
            ( { model
                | introModel = newIntroModel
              }
            , Cmd.map IntroMsg cmd
            )


changeWindowFocus : Window -> Model -> Model
changeWindowFocus window model =
    { model
        | windowsOrder = List.filter (\elem -> elem /= window) model.windowsOrder |> List.append [ window ]
    }


closeWindow : Window -> Model -> Model
closeWindow window model =
    { model
        | openWindows = List.filter (\elem -> elem /= window) model.openWindows
        , windowsOrder = List.filter (\elem -> elem /= window) model.windowsOrder
    }


openWindow : Window -> Model -> Model
openWindow window model =
    { model
        | openWindows = List.filter (\elem -> elem /= window) model.openWindows |> List.append [ window ]
        , windowsOrder = List.filter (\elem -> elem /= window) model.windowsOrder |> List.append [ window ]
    }



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "desktop" ]
        [ introView model ]


introView : Model -> Html Msg
introView { introModel } =
    map IntroMsg (Intro.view introModel)
