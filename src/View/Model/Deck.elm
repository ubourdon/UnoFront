module View.Model.Deck exposing (..)

import Html exposing (div, Attribute, Html, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import View.Util.Dimensions exposing (..)
import View.Model.Model exposing (Model)
import View.Service.CardViewService exposing (showCard)
import Service.Message exposing (Msg(..))

-- utils

-- simple deck
deck : DeckDimension -> List (Attribute msg) -> List (Html msg) -> Html msg
deck dim attr = div ([deckStyle dim] ++ attr)

deckStyle : DeckDimension -> Attribute msg
deckStyle (w, h) =
  style
    [ ("width", (toString w) ++ "px")
    , ("height", (toString h) ++ "px")
    , ("border", "solid 2px white")
    , ("marginRight", "20px")
    , ("border-radius", "10px")
    ]

-- end utils

-- player deck ====> move to Util & rename to absolute position
deckPlayerStyle : (ElemPosition, ElemPosition) -> Attribute msg -- use (VerticalPos, HorzontalPos)
deckPlayerStyle ((vert_pos, vert_value), (hor_pos, hor_value)) =
  style
    [ ("position", "absolute")
    , (stringPosition vert_pos, (toString vert_value) ++ "px")
    , (stringPosition hor_pos, (toString hor_value) ++ "px")
    , ("display", "flex")
    , ("cursor", "pointer")
    ]


hiddenFaceCardStyle : Int -> Int -> Attribute msg
hiddenFaceCardStyle w h =
    style [ ("backgroundColor", "#FF0000")
    , ("width", (toString (w-2)) ++ "px")
    , ("height", (toString (h-2)) ++ "px")
    , ("color", "white")
    , ("border-radius", "10px")
    , ("padding-top", "2px")
    , ("padding-left", "2px")
    ]

hiddenFaceCard : DeckDimension -> List (Html.Attribute msg) -> Html msg
hiddenFaceCard (w,h) attribute = deck (w,h) [] [div ([hiddenFaceCardStyle w h] ++ attribute) [text "UNO"]]

-- top deck
topDeck : WindowWidth -> WindowHeight -> Html msg
topDeck w h = div [deckPlayerStyle (topDeckPosition w h deckDimension)] [hiddenFaceCard deckDimension []]

topDeckPosition : WindowWidth -> WindowHeight -> DeckDimension -> (ElemPosition, ElemPosition)
topDeckPosition w h (dimX, dimY) = (top 50, calculDeckXPosition w dimX |> right)

-- right deck
rightDeck : WindowWidth -> WindowHeight -> Html msg
rightDeck w h = div [deckPlayerStyle (rightDeckPosition w h deckDimension)] [hiddenFaceCard deckDimension []]

rightDeckPosition : WindowWidth -> WindowHeight -> DeckDimension -> (ElemPosition, ElemPosition)
rightDeckPosition w h (dimX, dimY) = (calculDeckYPosition h dimY |> top, right 50)

-- left deck
leftDeck : WindowWidth -> WindowHeight -> Html msg
leftDeck w h = div [deckPlayerStyle (leftDeckPosition w h deckDimension)] [hiddenFaceCard deckDimension []]

leftDeckPosition : WindowWidth -> WindowHeight -> DeckDimension -> (ElemPosition, ElemPosition)
leftDeckPosition w h (dimX, dimY) = (calculDeckYPosition h dimY |> top, left 50)

-- bottom deck
bottomDeck : Model -> Html Msg
bottomDeck model =
  let (w,h) = (model.windowSize.width,model.windowSize.height)
      playerCards = model.playerCards
      (deckX, deckY) = focusCardDimension
      newDeckX = (deckX + 38) * List.length playerCards
      newDeckDim = (newDeckX, deckY)
      displayCard = \card -> deck focusCardDimension [onClick (PlayCard card)] [showCard card]
  in
      div [deckPlayerStyle (bottomDeckPosition w h newDeckDim)]
          (List.map displayCard playerCards)

bottomDeckPosition : WindowWidth -> WindowHeight -> DeckDimension -> (ElemPosition, ElemPosition)
bottomDeckPosition w h (dimX, dimY) = (bottom 50, calculDeckXPosition w dimX |> right)

-- center game deck
gameDeck : Model -> List (Html msg) -> Html msg
gameDeck model =
  let (w, h) = (model.windowSize.width, model.windowSize.height)
  in div [gameDeckStyle (calculDeckPosition w h gameDeckDimension)]

gameDeckStyle : (TopPosition, RightPosition) -> Attribute msg
gameDeckStyle (top_pos, right_pos) =
  style
    [ ("margin", "0 auto")
    , ("width", "265px")
    , ("display", "flex")
    , ("position", "absolute")
    , ("top", (toString top_pos) ++ "px")
    , ("right", (toString right_pos) ++ "px")
    ]

calculDeckPosition : WindowWidth -> WindowHeight -> DeckDimension -> (TopPosition, RightPosition)
calculDeckPosition w h (deckDimX, deckDimY) = (calculDeckYPosition h deckDimY, calculDeckXPosition w deckDimX)

calculDeckXPosition: WindowWidth -> DeckWidth -> Float
calculDeckXPosition width dimX = ((toFloat width) / 2) - ((toFloat dimX) / 2)

calculDeckYPosition : WindowHeight -> DeckHeight -> Float
calculDeckYPosition height dimY = ((toFloat height) / 2) - ((toFloat dimY) / 2) - 50
