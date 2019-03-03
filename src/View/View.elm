module View.View exposing (..)

import View.Util.Dimensions exposing (..)
import Html exposing (..)
import Html.Attributes exposing (style)
import View.Model.Deck exposing (deck, gameDeck, topDeck, rightDeck, leftDeck, bottomDeck, hiddenFaceCard)
import MetaDashboard exposing (score)
import View.Model.Model exposing (Model)
import Html.Events exposing (onClick)
import Service.Message exposing (Action(..))
import Domain.Card exposing (Card(..))
import View.Service.CardViewService exposing (showCard)
import String exposing (fromInt)

greenCarpetStyle : WindowWidth -> WindowHeight -> List (Attribute msg)
greenCarpetStyle w h =
  [ style "width" ((fromInt w) ++ "px")
  , style "height" ((fromInt (h - 40)) ++ "px")
  , style "backgroundColor" "#097054"
  ]

headerStyle = [ style "height" "40px"
              , style "backgroundColor" "#6599FF"
              ]

viewCarpet : Model -> Html Action
viewCarpet model =
  let (w, h) = (model.windowSize.width, model.windowSize.height)
  in
    div (greenCarpetStyle w h)
        [ gameDeck model [lastCardPlayedDeck model, packageCardsDeck model]
        , score
        , topDeck w h
        , rightDeck w h
        , leftDeck w h
        , bottomDeck model
        ]

view : Model -> Html Action
view model =
  div [style "font-family" "Helvetica"]
    [ nav headerStyle [text "Hello, World! Ugo"]
    , viewCarpet model
    ]

lastCardPlayedDeck : Model -> Html Action
lastCardPlayedDeck model =
  let displayDeck = deck focusCardDimension []
  in case model.lastCardPlayed of
    Just card -> displayDeck [showCard card]
    Nothing -> displayDeck []

packageCardsDeck : Model -> Html Action
packageCardsDeck model =
  case model.cardPackage of
    nextCard :: _ -> hiddenFaceCard focusCardDimension [onClick (PickCard nextCard), style "cursor" "pointer"]
    [] -> deck focusCardDimension [] []