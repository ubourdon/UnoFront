module Domain.Card exposing (Card(..), CardColor(..), CardNumericValue(..))

type Card = NumericCard CardColor CardNumericValue |
            PlusTwoCard CardColor |
            StopCard CardColor |
            KickBackCard CardColor |
            PlusFourCard |
            ChangeColorCard

type CardColor = Red | Yellow | Green | Blue
type CardNumericValue = Zero | One | Two | Three | Four | Five | Six | Seven | Eight | Nine