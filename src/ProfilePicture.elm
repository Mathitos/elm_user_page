module ProfilePicture exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, src)
import WindowHeader exposing (windowHeader)


view : Html msg
view =
    div [ class "profile-picture" ]
        [ windowHeader "profile-photo.jpg"
        , img [ src "https://avatars.githubusercontent.com/u/12518699?s=460&u=48e548b6beeb19e010cfb1ed3635dca26d55a0a4&v=4" ] []
        ]
