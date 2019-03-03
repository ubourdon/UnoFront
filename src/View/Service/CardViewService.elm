module View.Service.CardViewService exposing (showCard)

import Domain.Card exposing (Card(..), CardColor(..), CardNumericValue(..))
import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (style)
import View.Util.Dimensions exposing (focusCardDimension)
import String exposing (fromInt)

showCard : Card -> Html msg
showCard card =
  case card of
    NumericCard color value -> htmlCard (showColor color) (showCardNumericValue value)
    PlusTwoCard color -> htmlCard (showColor color) "+2"
    StopCard color -> htmlCard (showColor color) "ø"
    KickBackCard color -> htmlCard (showColor color) "<="
    PlusFourCard -> htmlCard "black" "+4"
    ChangeColorCard -> htmlCard "black" "J"

showColor : CardColor -> String
showColor color =
  case color of
    Red -> "red"
    Yellow -> "yellow"
    Green -> "green"
    Blue -> "blue"

showCardNumericValue : CardNumericValue -> String
showCardNumericValue value =
  case value of
    Zero -> "0"
    One -> "1"
    Two -> "2"
    Three -> "3"
    Four -> "4"
    Five -> "5"
    Six -> "6"
    Seven -> "7"
    Eight -> "8"
    Nine -> "9"

htmlCard : String -> String-> Html msg
htmlCard color value =
  let (_, h) = focusCardDimension
      paddingText = 45
      cardHeight = h - 45
  in div [ style "background-color" color
         , style "text-align" "center"
         , style "padding-top" (fromInt paddingText ++ "px")
         , style "height" (fromInt cardHeight ++ "px")
         , style "border-radius" "10px"
         , style "color" "white"
         , style "font-size" "5em"
         ]
         [text value]