module Service.Message exposing (..)

import View.Model.Model exposing (WindowDimensions)
import Domain.Card exposing (Card(..))

type Msg = GetWindowDimensions WindowDimensions |
           PickCard Card |
           PlayCard Card