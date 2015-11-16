import Html exposing (..)
import Html.Attributes exposing (style)
import Window
import Dimensions exposing (..)
import Deck exposing (deck, gameDeck, topDeck, rightDeck, leftDeck, bottomDeck)

greenCarpetStyle : WindowHeight -> Attribute
greenCarpetStyle h = style
  [ ("width", "100%")
  , ("height", (toString (h - 40)) ++ "px")
  , ("backgroundColor", "#097054")
  ]

headerStyle = style [("height", "40px")]

viewCarpet : WindowWidth -> WindowHeight -> Html
viewCarpet w h =
  div [greenCarpetStyle h]
    [ gameDeck w h
        [ deck []
        , deck []
        ]
    , topDeck w h
    , rightDeck w h
    , leftDeck w h
    , bottomDeck w h
    ]

view : (Int, Int) -> Html
view (w, h) =
  div []
    [ nav [headerStyle] [text "Hello, World! Ugo"]
    , viewCarpet w h
    ]

main : Signal Html
main = Signal.map view Window.dimensions
