module Deck exposing (..)

import Html exposing (div, Attribute, Html, text)
import Html.Attributes exposing (style)
import View.Util.Dimensions exposing (..)

-- utils

-- simple deck
deck : List (Html msg) -> Html msg
deck = div [deckStyle]

deckStyle =
  style
    [ ("width", "90px")
    , ("height", "130px")
    , ("border", "solid 2px white")
    , ("display", "inline-block")
    , ("marginRight", "20px")
    , ("border-radius", "10px")
    ]

-- end utils

-- player deck ====> move to Util & rename to absolute position
deckPlayerStyle : (ElemPosition, ElemPosition) -> Attribute msg -- use (VerticalPos, HorzontalPos)
deckPlayerStyle ((vert_pos, vert_value), (hor_pos, hor_value))  =
  style
    [ ("position", "absolute")
    , (stringPosition vert_pos, (toString vert_value) ++ "px")
    , (stringPosition hor_pos, (toString hor_value) ++ "px")
    ]

hiddenFaceCardStyle =
  style
    [ ("backgroundColor", "#FF0000")
    , ("width", "88px")
    , ("height", "128px")
    , ("color", "white")
    , ("border-radius", "10px")
    , ("padding-top", "2px")
    , ("padding-left", "2px")
    ]

hiddenFaceCard : Html msg
hiddenFaceCard = deck [div [hiddenFaceCardStyle] [text "UNO"]]

-- top deck
topDeck : WindowWidth -> WindowHeight -> Html msg
topDeck w h = div [deckPlayerStyle (topDeckPosition w h deckDimension)] [hiddenFaceCard]

topDeckPosition : WindowWidth -> WindowHeight -> DeckDimension -> (ElemPosition, ElemPosition)
topDeckPosition w h (dimX, dimY) = (top 50, calculDeckXPosition w dimX |> right)

-- right deck
rightDeck : WindowWidth -> WindowHeight -> Html msg
rightDeck w h = div [deckPlayerStyle (rightDeckPosition w h deckDimension)] [hiddenFaceCard]

rightDeckPosition : WindowWidth -> WindowHeight -> DeckDimension -> (ElemPosition, ElemPosition)
rightDeckPosition w h (dimX, dimY) = (calculDeckYPosition h dimY |> top, right 50)

-- left deck
leftDeck : WindowWidth -> WindowHeight -> Html msg
leftDeck w h = div [deckPlayerStyle (leftDeckPosition w h deckDimension)] [hiddenFaceCard]

leftDeckPosition : WindowWidth -> WindowHeight -> DeckDimension -> (ElemPosition, ElemPosition)
leftDeckPosition w h (dimX, dimY) = (calculDeckYPosition h dimY |> top, left 50)

-- bottom deck
bottomDeck : WindowWidth -> WindowHeight -> Html msg
bottomDeck w h =
  let (deckX, deckY) = deckDimension
      newDeckX = (deckX + 20) * 5
      newDeckDim = (newDeckX, deckY)
  in
      div [deckPlayerStyle (bottomDeckPosition w h newDeckDim)]
          (List.repeat 5 (deck []))

bottomDeckPosition : WindowWidth -> WindowHeight -> DeckDimension -> (ElemPosition, ElemPosition)
bottomDeckPosition w h (dimX, dimY) = (bottom 50, calculDeckXPosition w dimX |> right)

-- center game deck
gameDeck : WindowWidth -> WindowHeight -> List (Html msg) -> Html msg
gameDeck w h = div [gameDeckStyle (calculDeckPosition w h gameDeckDimension)]

gameDeckStyle : (TopPosition, RightPosition) -> Attribute msg
gameDeckStyle (top_pos, right_pos) =
  style
    [ ("margin", "0 auto")
    , ("width", "250px")
    , ("position", "absolute")
    , ("top", (toString top_pos) ++ "px")
    , ("right", (toString right_pos) ++ "px")
    ]

calculDeckPosition : WindowWidth -> WindowHeight -> DeckDimension -> (TopPosition, RightPosition)
calculDeckPosition w h (deckDimX, deckDimY) = (calculDeckYPosition h deckDimY, calculDeckXPosition w deckDimX)

calculDeckXPosition: WindowWidth -> DeckWidth -> Float
calculDeckXPosition width dimX = ((toFloat width) / 2) - ((toFloat dimX) / 2)

calculDeckYPosition : WindowHeight -> DeckHeight -> Float
calculDeckYPosition height dimY = ((toFloat height) / 2) - ((toFloat dimY) / 2)
