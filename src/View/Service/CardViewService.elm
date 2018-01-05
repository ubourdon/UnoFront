module View.Service.CardViewService exposing (showCard)

import Domain.Card exposing (Card(..), CardColor(..), CardNumericValue(..))
import Html exposing (Html, text)

showCard : Card -> Html msg
showCard card =
  case card of
    NumericCard color value -> text (showColor color ++ showCardNumericValue value)
    PlusTwoCard color -> text ("+2" ++ " " ++ showColor color)
    StopCard color -> text ("ø" ++ " " ++ showColor color)
    KickBackCard color -> text ("=> <=" ++ " " ++ showColor color)
    PlusFourCard -> text "+4"
    ChangeColorCard -> text "Change Color"

showColor : CardColor -> String
showColor color =
  case color of
    Red -> "Rouge"
    Yellow -> "Jaune"
    Green -> "Vert"
    Blue -> "Bleu"

showCardNumericValue : CardNumericValue -> String
showCardNumericValue value =
  case value of
    Zero -> "Zero"
    One -> "One"
    Two -> "Two"
    Three -> "Three"
    Four -> "Four"
    Five -> "Five"
    Six -> "Six"
    Seven -> "Seven"
    Eight -> "Height"
    Nine -> "Nine"