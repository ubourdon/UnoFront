module View.View exposing (..)

import Html exposing (Html)
import View.Model.Deck exposing (lastCardPlayedDeck, otherPlayerHiddenFaceCard, packageCardsDeck, playerDeck)
import View.Model.Model exposing (Model)
import Service.Message exposing (Action(..))
import Html.Styled exposing (div, toUnstyled, nav, text, Attribute)
import Html.Styled.Attributes exposing (css)
import Css exposing (absolute, auto, backgroundColor, center, displayFlex, fontFamilies, height, hex, margin, overflow, padding, pct, position, property, px, relative, textAlign, width)


view : Model -> Html Action
view model =
  (div [ layoutStyle ]
    [ nav [ headerStyle ] [text "Hello, World! Ugo"]
    , viewCarpet model
    ] |> toUnstyled)

viewCarpet model =
    div [ greenCarpetStyle ]
        [ div [ topLeft ]       [ ]
        , div [ topCenter, centerElemInBox ] [ otherPlayerHiddenFaceCard [] ]
        , div [ topRight ]      [ ]
        , div [ middleLeft, centerElemInBox ]    [ otherPlayerHiddenFaceCard [] ]

        , div [ middleCenter, centerElemInBox ]
              [ div [css [ displayFlex ] ] [ lastCardPlayedDeck model, packageCardsDeck model ] ]

        , div [ middleRight, centerElemInBox ]
              [ otherPlayerHiddenFaceCard [] ]

        , div [ bottom, centerElemInBox ] [ playerDeck model ]
        ]

centerElemInBox = css [ property "align-self" "center"
                      , property "justify-self" "center"
                      ]

layoutStyle = css [ fontFamilies ["Helvetica"]
                  , property "display" "grid"
                  , property "grid-template-rows" "10% 1fr"
                  , position absolute
                  , height (pct 100)
                  , width (pct 100)
                  , textAlign center
                  ]

headerStyle = css [ backgroundColor <| hex "#6599FF"
                  , property "grid-row" "1"
                  ]



greenCarpetStyle = css [ backgroundColor <| hex "#097054"
                       , property "grid-row" "2"
                       , property "display" "grid"
                       , property "grid-template-rows" "30% 1fr 40%"
                       ]

topLeft = css [ property "grid-row" "1", property "grid-column" "1" ]
topCenter = css [ property "grid-row" "1", property "grid-column" "2" ]
topRight = css [ property "grid-row" "1", property "grid-column" "3" ]
middleLeft = css [ property "grid-row" "2", property "grid-column" "1" ]
middleCenter = css [ property "grid-row" "2", property "grid-column" "2" ]
middleRight = css [ property "grid-row" "2", property "grid-column" "3" ]
bottom = css [ property "grid-row" "3", property "grid-column" "1 / span 3" ]