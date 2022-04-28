Class {
	#name : #GameplayTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameplayTests >> test010ASpaceShipIsNotLongerInTheSamePositionAfterRollingADie [

	| aSpaceGame aBoard aDie initialPositionOfSpaceship finalPositionOfSpaceship |
	aBoard := StraightBoard withPositions: 10.
	aDie := Die withSides: 5.

	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aDie
		              andSpaceShips: { 'Messi' }.

	initialPositionOfSpaceship := aSpaceGame positionOfSpaceship: 'Messi'.
	aSpaceGame playTurnOfSpaceship: 'Messi'.
	finalPositionOfSpaceship := aSpaceGame positionOfSpaceship: 'Messi'.

	self
		deny: initialPositionOfSpaceship
		equals: finalPositionOfSpaceship
]

{ #category : #tests }
GameplayTests >> testASpaceGameCannotBePlayedMoreThanOnce [

	| aSpaceGame aBoard aDie |
	aBoard := StraightBoard withPositions: 50.
	aDie := Die withSides: 5.

	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aDie
		              andSpaceShips: { 'Messi' }.

	aSpaceGame playGame.

	self
		should: [ aSpaceGame playGame ]
		raise: Error
		whoseDescriptionIncludes: 'Game cannot be played since it is finished'
		description: 'The Space Game has finished and cannot be played again'
]

{ #category : #tests }
GameplayTests >> testASpaceGameCannotPlayAnotherRoundAfterTheGameHasFinished [

	| aSpaceGame aBoard aDie |
	aBoard := StraightBoard withPositions: 50.
	aDie := Die withSides: 5.

	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aDie
		              andSpaceShips: { 'Messi' }.

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
	aDie := Die withSides: 5.

	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aDie
		              andSpaceShips: { 'Messi' }.
	
	aSpaceGame playGame.

	self assert: aSpaceGame isFinished.
]
