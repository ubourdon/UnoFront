import Html exposing (program)
import Window
import Task
import View.View exposing (view)
import Service.Message exposing (Msg(..))
import Service.Update exposing (update)
import Domain.CardPackage exposing (fullCardPackage)
import View.Model.Model exposing (Model, WindowDimensions)

stubDim = Model (WindowDimensions 600 800) [] fullCardPackage Nothing

initDim: Cmd Msg
initDim = Task.perform GetWindowDimensions (Task.map (\size -> WindowDimensions size.height size.width) Window.size)

main = Html.program
    { init = (stubDim, initDim)
    , view = view
    , update = update
    , subscriptions = (\_ -> Window.resizes GetWindowDimensions)
    }