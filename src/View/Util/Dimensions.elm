module View.Util.Dimensions exposing (..)

type alias WindowHeight = Int
type alias WindowWidth = Int

type alias DeckWidth = Int
type alias DeckHeight = Int
type alias DeckDimension = (DeckWidth, DeckHeight)

gameDeckDimension : DeckDimension
gameDeckDimension = (265, 130)

deckDimension : DeckDimension
deckDimension = (90, 130)

focusCardDimension : DeckDimension
focusCardDimension = (108, 156)