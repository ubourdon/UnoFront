import Html exposing (..)
import Html.Attributes exposing (style)
import Window
import Task
import View.Util.Dimensions exposing (..)
import Deck exposing (deck, gameDeck, topDeck, rightDeck, leftDeck, bottomDeck, hiddenFaceCard)
import MetaDashboard exposing (score)

greenCarpetStyle : WindowWidth -> WindowHeight -> Attribute msg
greenCarpetStyle w h = style
  [ ("width", (toString w) ++ "px")
  , ("height", (toString (h - 40)) ++ "px")
  , ("backgroundColor", "#097054")
  ]

headerStyle = style [("height", "40px"),("backgroundColor", "#6599FF")]

viewCarpet : WindowWidth -> WindowHeight -> Html msg
viewCarpet w h =
  div [greenCarpetStyle w h]
    [ gameDeck w h
        [ deck []
        , deck [] --hiddenFaceCard
        ]
    , score
    , topDeck w h
    , rightDeck w h
    , leftDeck w h
    , bottomDeck w h
    ]

view : Model -> Html msg
view model =
  div [style [("font-family", "Helvetica")]]
    [ nav [headerStyle] [text "Hello, World! Ugo"]
    , viewCarpet model.windowSize.width model.windowSize.height
    ]

type alias Model =
    { windowSize : WindowDimensions
    }

type alias WindowDimensions =
    { height: Int
    , width: Int
    }

stubDim = { windowSize = { height = 600, width = 800 } }
windowDimensions h w = { height = h, width = w }

initDim: Cmd Msg
initDim = Task.perform GetWindowDimensions (Task.map (\size -> windowDimensions size.height size.width) (Window.size))

type Msg = GetWindowDimensions WindowDimensions

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GetWindowDimensions dim -> ( { model | windowSize = dim }, Cmd.none)

main = Html.program
    { init = (stubDim, initDim)
    , view = view
    , update = update
    , subscriptions = (\_ -> Window.resizes GetWindowDimensions)
    }