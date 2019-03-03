module Main exposing (main)

import View.View exposing (view)
import Service.Message exposing (Action(..))
import Service.Update exposing (update)
import Domain.CardPackage exposing (fullCardPackage)
import View.Model.Model exposing (Model, WindowDimensions)
import Browser

stubDim = Model (WindowDimensions 600 800) [] fullCardPackage Nothing

--initDim: Cmd Action
--initDim = Task.perform GetWindowDimensions (Task.map (\size -> WindowDimensions size.height size.width) )

main = Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

init : () -> (Model, Cmd Action )
init _ = (stubDim, Cmd.none)

subscriptions : Model -> Sub Action
subscriptions _ = Sub.none