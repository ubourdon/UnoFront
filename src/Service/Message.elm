module Service.Message exposing (..)

import Domain.Card exposing (Card(..))

type Action = PickCard Card
            | PlayCard Card