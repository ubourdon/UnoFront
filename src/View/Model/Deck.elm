module View.Model.Deck exposing (otherPlayerHiddenFaceCard, hiddenFaceCard, playerDeck, lastCardPlayedDeck, packageCardsDeck{-, deck-})

import Html.Styled exposing (Attribute, Html, div, text)
import Html.Styled.Attributes exposing (style)
import Html.Styled.Events exposing (onClick)
import View.Util.Dimensions exposing (..)
import View.Model.Model exposing (Model)
import View.Service.CardViewService exposing (showCard)
import Service.Message exposing (Action(..))
import String exposing (fromInt)


lastCardPlayedDeck model =
  let displayDeck = deck focusCardDimension []
  in case model.lastCardPlayed of
    Just card -> displayDeck [showCard card]
    Nothing -> displayDeck []

packageCardsDeck model =
  case model.cardPackage of
    nextCard :: _ -> hiddenFaceCard focusCardDimension [onClick (PickCard nextCard), style "cursor" "pointer"]
    [] -> deck focusCardDimension [] []

otherPlayerHiddenFaceCard : List (Attribute msg) -> Html msg
otherPlayerHiddenFaceCard attribute = hiddenFaceCard deckDimension attribute

hiddenFaceCard : DeckDimension -> List (Attribute msg) -> Html msg
hiddenFaceCard dim attribute = deck dim [] [div ((hiddenFaceCardStyle dim) ++ attribute) [text "UNO"]]

playerDeck : Model -> Html Action
playerDeck model =
    let playerCards = model.playerCards
        displayCard = \card -> deck focusCardDimension [onClick (PlayCard card)] [showCard card]

    in div (deckPlayerStyle) (List.map displayCard playerCards)

hiddenFaceCardStyle : DeckDimension -> List (Attribute msg)
hiddenFaceCardStyle (w,h) =
    [ style "backgroundColor" "#FF0000"
    , style "width" ((fromInt (w-2)) ++ "px")
    , style "height" ((fromInt (h-2)) ++ "px")
    , style "color" "white"
    , style "border-radius" "10px"
    , style "padding-top" "2px"
    , style "padding-left" "2px"
    ]

deckPlayerStyle : List (Attribute msg)
deckPlayerStyle =
    [ style "display" "flex"
    , style "cursor" "pointer"
    ]

-- utils

-- simple deck
deck : DeckDimension -> List (Attribute msg) -> List (Html msg) -> Html msg
deck dim attr = div ((deckStyle dim) ++ attr)

deckStyle : DeckDimension -> List (Attribute msg)
deckStyle (w, h) =
    [ style "width" ((fromInt w) ++ "px")
    , style "height" ((fromInt h) ++ "px")
    , style "border" ("solid 2px white")
    , style "marginRight" "20px"
    , style "border-radius" "10px"
    ]

-- end utils