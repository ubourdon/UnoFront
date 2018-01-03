module Domain.Card exposing (Card(..))

type Card = NumericCard Color Value |
            PlusTwoCard Color |
            StopCard Color |
            KickBackCard Color |
            PlusFourCard |
            ChangeColorCard

type Color = Red | Yellow | Green | Blue
type Value = Zero | One | Two | Three | Four | Five | Six | Seven | Height | Nine