module Service.Message exposing (..)

import View.Model.Model exposing (WindowDimensions)
import Domain.Card exposing (Card(..))

type Action = GetWindowDimensions WindowDimensions
    | PickCard Card
    | PlayCard Card