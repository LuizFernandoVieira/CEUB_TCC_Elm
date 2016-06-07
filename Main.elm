import Html exposing (Html, Attribute, div, p, input, text)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String

import Svg exposing (..)
import Svg.Attributes exposing (..)

import Model.Direction as Direction exposing (Direction(..))
import Model.Keys as Keys exposing (Keys)

import Keyboard exposing (KeyCode)

-- MAIN

main =
  Html.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Action
subscriptions _ =
  [ Keyboard.downs (Keys.keyChange True >> KeyChange)
  , Keyboard.ups (Keys.keyChange False >> KeyChange)
  ]
  |> Sub.batch

-- MODEL

type alias Model =
  { name : String
  , keys : Keys
  }

type alias Keys =
  { left : Bool
  , right : Bool
  }

init : (Model, Cmd Action)
init =
  (model, Cmd.none)

model =
  { name = "Mesquita"
  , keys = Keys False False
  }

keyChange : Bool -> KeyCode -> (Keys -> Keys)
keyChange on keyCode =
  case keyCode of
    37 -> \k -> {k | left = on}
    39 -> \k -> {k | right = on}
    _ -> \_ -> _

-- UPDATE

type Action
  = NewName String
  | Reset

update : Action -> Model -> (Model, Cmd Action)
update action model =
  case action of
    NewName novonome ->
      { model | name = novonome } ! []

    Reset ->
      Model "" ! []


-- VIEW

view : Model -> Html Action
view model =
  div [ otherStyle ] []

myStyle =
  Html.Attributes.style
    [ ("background-color","#aaa")
    , ("margin", "100px 100px 100px 100px")
    , ("color", "white")
    ]

otherStyle =
  Html.Attributes.style
    [ ("background-color", "blue")
    , ("width", "100px")
    , ("height", "100px")
    , ("margin-left", "10%")
    , ("margin-top", "10%")
    ]

-- div [ Html.Attributes.style [("width", "5%"), ("height", "5%")] ]
-- [
--   svg [ version "1.1", x "0", y "0", viewBox "0 0 323.141 322.95" ]
--       [ polygon [ fill "#000000", points "161.649,152.782 231.514,82.916 91.783,82.916" ] []
--       , polygon [ fill "#000000", points "8.867,0 79.241,70.375 232.213,70.375 161.838,0" ] []
--       , rect
--           [ fill "#000000", x "192.99", y "107.392", Svg.Attributes.width "107.676", Svg.Attributes.height "108.167"
--           , transform "matrix(0.7071 0.7071 -0.7071 0.7071 186.4727 -127.2386)"
--           ]
--           []
--       , polygon [ fill "#000000", points "323.298,143.724 323.298,0 179.573,0" ] []
--       , polygon [ fill "#000000", points "152.781,161.649 0,8.868 0,314.432" ] []
--       , polygon [ fill "#000000", points "255.522,246.655 323.298,314.432 323.298,178.879" ] []
--       , polygon [ fill "#000000", points "161.649,170.517 8.869,323.298 314.43,323.298" ] []
--       ]
-- ]

-- [
--   svg [ version "1.1", x "0", y "0", viewBox "0 0 323.141 322.95" ]
--       [ polygon [ fill "#F0AD00", points "161.649,152.782 231.514,82.916 91.783,82.916" ] []
--       , polygon [ fill "#7FD13B", points "8.867,0 79.241,70.375 232.213,70.375 161.838,0" ] []
--       , rect
--           [ fill "#7FD13B", x "192.99", y "107.392", Svg.Attributes.width "107.676", Svg.Attributes.height "108.167"
--           , transform "matrix(0.7071 0.7071 -0.7071 0.7071 186.4727 -127.2386)"
--           ]
--           []
--       , polygon [ fill "#60B5CC", points "323.298,143.724 323.298,0 179.573,0" ] []
--       , polygon [ fill "#5A6378", points "152.781,161.649 0,8.868 0,314.432" ] []
--       , polygon [ fill "#F0AD00", points "255.522,246.655 323.298,314.432 323.298,178.879" ] []
--       , polygon [ fill "#60B5CC", points "161.649,170.517 8.869,323.298 314.43,323.298" ] []
--       ]
-- ]
