module MetaDashboard exposing (..)

import Html exposing (div, Attribute, Html, text)
import Html.Attributes exposing (style)
import View.Util.Dimensions exposing (..)

score : Html msg
score = div [] [text "toto"]

scoreStyle : WindowWidth -> WindowHeight -> List (Attribute msg)
scoreStyle w h =
    [ style "position" "absolute"
  --  , (stringPosition vert_pos, (toString vert_value) ++ "px")
  --  , (stringPosition hor_pos, (toString hor_value) ++ "px")
    , style "backgroundColor" "red"  -- temporary
    ]
