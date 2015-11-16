module Dimensions where

type alias WindowHeight = Int
type alias WindowWidth = Int

type alias DeckWidth = Int
type alias DeckHeight = Int
type alias DeckDimension = (DeckWidth, DeckHeight)

gameDeckDimension : DeckDimension
gameDeckDimension = (250, 130)

deckDimension : DeckDimension
deckDimension = (90, 130)

type alias TopPosition = Float
type alias RightPosition = Float

type alias ElemPosition = (Position, Float)

type Position = Top | Bottom | Left | Right

top : Float -> ElemPosition
top value = (Top, value)

left : Float -> ElemPosition
left value = (Left, value)

right : Float -> ElemPosition
right value = (Right, value)

bottom : Float -> ElemPosition
bottom value = (Bottom, value)

stringPosition : Position -> String
stringPosition pos = case pos of
                        Top -> "top"
                        Bottom -> "bottom"
                        Left -> "left"
                        Right -> "right"
