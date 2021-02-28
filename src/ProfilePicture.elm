module ProfilePicture exposing (view)


view : Html Msg
view =
    div [ class "profile-picture" ]
        [ img [ src "https://sourcedigit.com/wp-content/uploads/2020/03/Focal-Fossa_1.png" ]
        ]
