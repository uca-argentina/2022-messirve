Class {
	#name : #LoadedDIeGameplayTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
LoadedDIeGameplayTests >> testAGameCannotBeAskedForAWinnerWhenItHasNotFinished [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 3.
	aBoard := StraightBoard withPositions: 6.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie.
	aSpaceGame playNextTurn.

	self
		should: [ aSpaceGame winner ]
		raise: Error
		whoseDescriptionIncludes:
		'There is no winner'
		description: 'Nonexistent winner, game in progress'
]

{ #category : #tests }
LoadedDIeGameplayTests >> testASpaceShipReachesTheLastPositionAndIsTheWinner [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 10.
	aBoard := StraightBoard withPositions: 6.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie.
	aSpaceGame playNextTurn.

	self assert: aSpaceGame winner equals: 'Messi'
]

{ #category : #tests }
LoadedDIeGameplayTests >> testIsPossibleToKnowPositionsOfSpaceshipsAfterGameEnded [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 3.
	aBoard := StraightBoard withPositions: 6.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul' }
		              on: aBoard
		              rolling: aLoadedDie.
	aSpaceGame playGame.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 6.
	self assert: (aSpaceGame positionOfSpaceship: 'De Paul') equals: 4
]

{ #category : #tests }
LoadedDIeGameplayTests >> testTheGameFinishesWhenASpaceShipGoesThroughTheFinishLine [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 10.
	aBoard := StraightBoard withPositions: 10.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie.
	aSpaceGame playNextTurn.

	self assert: aSpaceGame isFinished
]

{ #category : #tests }
LoadedDIeGameplayTests >> testTwoSpaceShipsPlayTheGameAndTheFirstOneWins [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 3.
	aBoard := StraightBoard withPositions: 6.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul' }
		              on: aBoard
		              rolling: aLoadedDie.
	aSpaceGame playGame.

	self assert: aSpaceGame isFinished.
	self assert: aSpaceGame winner equals: 'Messi'
]

{ #category : #tests }
LoadedDIeGameplayTests >> testTwoSpaceShipsPlayTheGameWithTwoDiceAndTheGameFinishes [

	| aSpaceGame aBoard aLoadedDie1 aLoadedDie2 aDiceCup |
	aLoadedDie1 := LoadedDie rolling: 3.
	aLoadedDie2 := LoadedDie rolling: 4.
	aDiceCup := DiceCup withAll: { 
			            aLoadedDie1.
			            aLoadedDie2 }.
	aBoard := StraightBoard withPositions: 35.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul' }
		              on: aBoard
		              rolling: aDiceCup.
	aSpaceGame playGame.

	self assert: aSpaceGame isFinished
]

{ #category : #tests }
LoadedDIeGameplayTests >> testWhenASpaceShipRollsOverTheBoardPositionsItLandsOnTheLastBoardPosition [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 25.
	aBoard := StraightBoard withPositions: 10.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie.
	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 10
]
