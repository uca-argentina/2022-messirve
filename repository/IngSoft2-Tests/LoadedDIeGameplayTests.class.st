Class {
	#name : #LoadedDIeGameplayTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
LoadedDIeGameplayTests >> test014TheGameFinishesWhenASpaceShipGoesThroughTheFinishLine [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 10.
	aBoard := StraightBoard withPositions: 10.
	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aLoadedDie
		              andSpaceShips: { 'Messi' }.
	aSpaceGame playTurnOfSpaceship: 'Messi'.

	self assert: aSpaceGame isFinished
]

{ #category : #tests }
LoadedDIeGameplayTests >> test016ASpaceShipReachesTheLastPositionAndIsTheWinner [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 10.
	aBoard := StraightBoard withPositions: 6.
	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aLoadedDie
		              andSpaceShips: { 'Messi' }.
	aSpaceGame playTurnOfSpaceship: 'Messi'.

	self assert: aSpaceGame winner equals: 'Messi'
]

{ #category : #tests }
LoadedDIeGameplayTests >> test018TwoSpaceShipsPlayTheGameAndTheFirstOneWins [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 3.
	aBoard := StraightBoard withPositions: 6.
	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aLoadedDie
		              andSpaceShips: { 'Messi'. 'De Paul' }.
	aSpaceGame playGame.

	self assert: aSpaceGame isFinished.
	self assert: aSpaceGame winner equals: 'Messi'.
]

{ #category : #tests }
LoadedDIeGameplayTests >> test019IsPossibleToKnowPositionsOfSpaceshipsAfterGameEnded [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 3.
	aBoard := StraightBoard withPositions: 6.
	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aLoadedDie
		              andSpaceShips: { 'Messi'. 'De Paul' }.
	aSpaceGame playGame.
	
	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 6.
	self assert: (aSpaceGame positionOfSpaceship: 'De Paul') equals: 4.
]

{ #category : #tests }
LoadedDIeGameplayTests >> testAGameCannotBeAskedForAWinnerWhenItHasNotFinished [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 3.
	aBoard := StraightBoard withPositions: 6.
	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aLoadedDie
		              andSpaceShips: { 'Messi' }.
	aSpaceGame playTurnOfSpaceship: 'Messi'.

	self
		should: [ aSpaceGame winner ]
		raise: Error
		whoseDescriptionIncludes: 'There is no winner since the game has not finished'
		description: 'Nonexistent winner, game in progress'
]

{ #category : #tests }
LoadedDIeGameplayTests >> testTwoSpaceShipsPlayTheGameWithTwoDiceAndTheGameFinishes [

	| aSpaceGame aBoard  aLoadedDie1 aLoadedDie2 aDiceCup|
	aLoadedDie1 := LoadedDie rolling: 3.
	aLoadedDie2 := LoadedDie rolling: 4.
	aDiceCup := DiceCup initializeWithDice: { aLoadedDie1 . aLoadedDie2 }.
	aBoard := StraightBoard withPositions: 35.
	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aDiceCup
		              andSpaceShips: { 'Messi' . 'De Paul' }.
	aSpaceGame playGame.

	self assert: aSpaceGame isFinished.
]

{ #category : #tests }
LoadedDIeGameplayTests >> testWhenASpaceShipRollsOverTheBoardPositionsItLandsOnTheLastBoardPosition [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 25.
	aBoard := StraightBoard withPositions: 10.
	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aLoadedDie
		              andSpaceShips: { 'Messi' }.
	aSpaceGame playTurnOfSpaceship: 'Messi'.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 10.
]
