module WindowHeader exposing (windowHeader)

import Html exposing (..)
import Html.Attributes exposing (class)


windowHeader : String -> Html msg
windowHeader title =
    div [ class "window-header" ]
        [ span [] [ text title ]
        , button [] [ text "-" ]
        , button [] [ text "□" ]
        , button [] [ text "x" ]
        ]
