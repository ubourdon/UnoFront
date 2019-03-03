module Service.Update exposing (update)

import Service.Message exposing (Action(..))
import View.Model.Model exposing (Model)
import Domain.Card exposing (Card(..))

update : Action -> Model -> (Model, Cmd Action)
update msg model =
    case msg of
        PickCard card -> (pickCardUpdateModel card model, Cmd.none)
        PlayCard card -> (playCardUpdateModel card model, Cmd.none)

pickCardUpdateModel : Card -> Model -> Model
pickCardUpdateModel card model = { model | playerCards = card :: model.playerCards, cardPackage = Maybe.withDefault [] (List.tail model.cardPackage) }

playCardUpdateModel : Card -> Model -> Model
playCardUpdateModel card model =
  { model |
    playerCards = List.filter (\c -> c /= card) model.playerCards
  , lastCardPlayed = Just card
  }