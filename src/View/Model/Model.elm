module View.Model.Model exposing (..)

import Domain.Card exposing (Card(..))
import Domain.CardPackage exposing (CardPackage)

type alias Model =
    { windowSize : WindowDimensions
    , playerCards : List Card
    , cardPackage : CardPackage
    , lastCardPlayed : Maybe Card
    }

type alias WindowDimensions = { height: Int , width: Int }