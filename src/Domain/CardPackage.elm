module Domain.CardPackage exposing (CardPackage, fullCardPackage)

import Domain.Card exposing (Card(..), CardColor(..), CardNumericValue(..))

type alias CardPackage = List Card

{-
108 cartes réparties comme suit :
    19 cartes bleues numérotées de 0 à 9 (le 0 en un seul exemplaire)
    19 cartes vertes numérotées de 0 à 9 (le 0 en un seul exemplaire)
    19 cartes rouges numérotées de 0 à 9 (le 0 en un seul exemplaire)
    19 cartes jaunes numérotées de 0 à 9 (le 0 en un seul exemplaire)
    8 cartes +2 (2 de chaque couleur : rouge, vert, jaune, bleu)
    8 cartes inversion (2 de chaque couleur : rouge, vert, jaune, bleu)
    8 cartes passe ton tour (2 de chaque couleur : rouge, vert, jaune, bleu)
    4 cartes Joker
    4 cartes Super Joker
-}
fullCardPackage: CardPackage
fullCardPackage =
  buildColoredNumericCard ++
  buildPlusTwoCard ++
  buildStopCard ++
  buildKickBackCard ++
  doubleCard PlusFourCard ++ doubleCard PlusFourCard ++
  doubleCard ChangeColorCard ++ doubleCard ChangeColorCard

buildColoredNumericCard : List Card
buildColoredNumericCard = numericCards Blue ++ numericCards Red ++ numericCards Green ++ numericCards Yellow

buildPlusTwoCard : List Card
buildPlusTwoCard = List.concatMap doubleCard [PlusTwoCard Red, PlusTwoCard Green, PlusTwoCard Yellow, PlusTwoCard Blue]

buildStopCard : List Card
buildStopCard = List.concatMap doubleCard [StopCard Red, StopCard Green, StopCard Yellow, StopCard Blue]

buildKickBackCard: List Card
buildKickBackCard = List.concatMap doubleCard [KickBackCard Red, KickBackCard Green, KickBackCard Yellow, KickBackCard Blue]

numericCards : CardColor -> List Card
numericCards color =
  (List.concatMap doubleCard [ NumericCard color One
                             , NumericCard color Two
                             , NumericCard color Three
                             , NumericCard color Four
                             , NumericCard color Five
                             , NumericCard color Six
                             , NumericCard color Seven
                             , NumericCard color Eight
                             , NumericCard color Nine
                             ]) ++ [NumericCard color Zero]

doubleCard : Card -> List Card
doubleCard card = [card, card]

blueNumericCard number = NumericCard Blue number
redNumericCard number = NumericCard Red number
yellowNumericCard number = NumericCard Yellow number
greenNumericCard number = NumericCard Green number