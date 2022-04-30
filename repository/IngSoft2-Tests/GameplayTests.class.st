Class {
	#name : #GameplayTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameplayTests >> test010ASpaceShipIsNotLongerInTheSamePositionAfterRollingADie [

	| aSpaceGame aBoard aDie initialPositionOfSpaceship finalPositionOfSpaceship |
	aBoard := StraightBoard withPositions: 10.
	aDie := RandomDie withSides: 5.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie.

	initialPositionOfSpaceship := aSpaceGame positionOfSpaceship: 'Messi'.
	aSpaceGame playNextTurn.
	finalPositionOfSpaceship := aSpaceGame positionOfSpaceship: 'Messi'.

	self
		deny: initialPositionOfSpaceship
		equals: finalPositionOfSpaceship
]

{ #category : #tests }
GameplayTests >> testASpaceGameCannotBePlayedMoreThanOnce [

	| aSpaceGame aBoard aDie |
	aBoard := StraightBoard withPositions: 50.
	aDie := RandomDie withSides: 5.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie.

	aSpaceGame playGame.

	self
		should: [ aSpaceGame playGame ]
		raise: Error
		whoseDescriptionIncludes:
		'Game cannot be played since it is finished'
		description:
		'The Space Game has finished and cannot be played again'
]

{ #category : #tests }
GameplayTests >> testASpaceGameCannotPlayAnotherRoundAfterTheGameHasFinished [

	| aSpaceGame aBoard aDie |
	aBoard := StraightBoard withPositions: 50.
	aDie := RandomDie withSides: 5.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie.

	aSpaceGame playGame.

	self
		should: [ aSpaceGame playRound ]
		raise: Error
		whoseDescriptionIncludes:
		'A round cannot be played after the game has finished'
		description:
		'The Space Game has finished and a round cannot be played again'
]

{ #category : #tests }
GameplayTests >> testASpaceShipPlaysAGameWithOneDieAndTheGameFinishes [

	| aSpaceGame aBoard aDie |
	aBoard := StraightBoard withPositions: 50.
	aDie := RandomDie withSides: 5.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie.

	aSpaceGame playGame.

	self assert: aSpaceGame isFinished
]

{ #category : #tests }
GameplayTests >> testSixSpaceShipsPlayAGameWithThreeDiceAndTheGameFinishes [

	| aSpaceGame aBoard aDiceCup |
	aBoard := StraightBoard withPositions: 150.
	aDiceCup := DiceCup withAll: { RandomDie withSides: 5 . RandomDie withSides: 7 . RandomDie withSides: 9 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' . 'De Paul' . 'Montiel' . 'Julian' . 'Milton' . 'Armani' }
		              on: aBoard
		              rolling: aDiceCup.

	aSpaceGame playGame.

	self assert: aSpaceGame isFinished
]
