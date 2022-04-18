Class {
	#name : #GameplayTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameplayTests >> test014TheGameFinishesWhenASpaceShipGoesThroughTheFinishLine [

	| aSpaceGame aDiceCup aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 10.
	aDiceCup := DiceCup initializeWithDice: { aLoadedDie }.
	aBoard := StraightBoard withPositions: 10.
	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aDiceCup
		              andSpaceShips: { 'Messi' }.
	aSpaceGame playTurnOfSpaceship: 'Messi'.

	self assert: aSpaceGame isFinished
]

{ #category : #tests }
GameplayTests >> test015MessiRollsTenOnABoardOfSixPositionsAndEndsInPositionSix [

	| aSpaceGame aDiceCup aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 10.
	aDiceCup := DiceCup initializeWithDice: { aLoadedDie }.
	aBoard := StraightBoard withPositions: 6.
	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aDiceCup
		              andSpaceShips: { 'Messi' }.
	aSpaceGame playTurnOfSpaceship: 'Messi'.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 6
]

{ #category : #tests }
GameplayTests >> test016MessiReachesTheLastPositionAndIsTheWinner [

	| aSpaceGame aDiceCup aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 10.
	aDiceCup := DiceCup initializeWithDice: { aLoadedDie }.
	aBoard := StraightBoard withPositions: 6.
	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aDiceCup
		              andSpaceShips: { 'Messi' }.
	aSpaceGame playTurnOfSpaceship: 'Messi'.

	self assert: aSpaceGame winner equals: 'Messi'
]

{ #category : #tests }
GameplayTests >> test017MessiAndDePaulPlayAGameAndTheGameFinishes [

	| aSpaceGame aDiceCup aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 10.
	aDiceCup := DiceCup initializeWithDice: { aLoadedDie }.
	aBoard := StraightBoard withPositions: 6.
	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aDiceCup
		              andSpaceShips: { 'Messi'. 'De Paul' }.
	aSpaceGame playGame.

	self assert: aSpaceGame isFinished
]

{ #category : #tests }
GameplayTests >> test018TwoPlayersPlayTheGameAndMessiWins [

	| aSpaceGame aDiceCup aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 3.
	aDiceCup := DiceCup initializeWithDice: { aLoadedDie }.
	aBoard := StraightBoard withPositions: 6.
	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aDiceCup
		              andSpaceShips: { 'Messi'. 'De Paul' }.
	aSpaceGame playGame.

	self assert: aSpaceGame winner equals: 'Messi'
]

{ #category : #tests }
GameplayTests >> test019IsPossibleToKnowPositionsOfSpaceshipsAfterGameEnded [

	| aSpaceGame aDiceCup aLoadedDie aBoard positionResult |
	aLoadedDie := LoadedDie rolling: 3.
	aDiceCup := DiceCup initializeWithDice: { aLoadedDie }.
	aBoard := StraightBoard withPositions: 6.
	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aDiceCup
		              andSpaceShips: { 'Messi'. 'De Paul' }.
	aSpaceGame playGame.

	positionResult := aSpaceGame spaceShipStatuses collect: [ :status | 
		                  status position ].

	self assert: positionResult equals: { 6. 4 }
]

{ #category : #tests }
GameplayTests >> test020ThereIsNoWinnerWhenTheGameIsNotFinished [

	| aSpaceGame aDiceCup aLoadedDie aBoard  |
	aLoadedDie := LoadedDie rolling: 3.
	aDiceCup := DiceCup initializeWithDice: { aLoadedDie }.
	aBoard := StraightBoard withPositions: 6.
	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aDiceCup
		              andSpaceShips: { 'Messi' }.
	aSpaceGame playRound.

	self assert: (aSpaceGame isFinished) equals: false.
]
