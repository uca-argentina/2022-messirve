Class {
	#name : #SpaceGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'spaceshipStatuses',
		'winner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpaceGame class >> assertPlayerNameNotDuplicated: spaceShips [ 

	| spaceShipsSetSize spaceShipsSize |
	
	spaceShipsSize := (spaceShips asOrderedCollection) size.
	spaceShipsSetSize := (spaceShips asSet) size. 
	
	(spaceShipsSetSize == spaceShipsSize)
	ifFalse: [ Error signal: 'Player name duplicated' ].
	
	
	
]

{ #category : #initialization }
SpaceGame class >> withBoard: aBoard diceCup: aDiceCup andSpaceShips: spaceShips [ 
	self assertPlayerNameNotDuplicated: spaceShips.
	^self new initializeWithBoard: aBoard diceCup: aDiceCup andSpaceShips: spaceShips.
	
]

{ #category : #playing }
SpaceGame >> assertValidRoundBeingPlayed [

	self isFinished ifTrue: [ 
		Error signal: 'A round cannot be played after the game has finished' ]
]

{ #category : #asserting }
SpaceGame >> assertWinnerExists [
	winner winnerExists
	ifTrue: [ ^winner spaceShipWinner ]
	ifFalse: [ Error signal: 'There is no winner since the game has not finished' ]
]

{ #category : #initialization }
SpaceGame >> assignSpaceshipStatusesFrom: spaceShipsNames [

	| spaceShips initialPosition |
	spaceShips := spaceShipsNames collect: [ :name | 
		              SpaceShip withName: name ].
	
	initialPosition := board startingPosition.
	
	spaceshipStatuses := spaceShips collect: [ :aSpaceShip | 
		                     SpaceShipStatus with: aSpaceShip placedAt: initialPosition ]
]

{ #category : #initialization }
SpaceGame >> initializeWithBoard: aBoard diceCup: aDiceCup andSpaceShips: spaceShipsNames [

	board := aBoard.
	diceCup := aDiceCup.
	winner := SpaceShipWinner initializeWithoutWinner.
	self assignSpaceshipStatusesFrom: spaceShipsNames.
]

{ #category : #testing }
SpaceGame >> isFinished [
	^winner winnerExists.
]

{ #category : #playing }
SpaceGame >> obtainSpaceShipStatusFrom: aSpaceShip [

	^ spaceshipStatuses detect: [ :status | 
		  status spaceShip name == aSpaceShip ]
]

{ #category : #playing }
SpaceGame >> playGame [

	self isFinished
		ifFalse: [ self playRound ]
		ifTrue: [ 
		Error signal: 'Game cannot be played since it is finished' ].
]

{ #category : #playing }
SpaceGame >> playRound [

	self assertValidRoundBeingPlayed.

	spaceshipStatuses do: [ :status | 
		self playTurnOfSpaceship: status spaceShip name ].

	self isFinished ifFalse: [ self playRound ]
]

{ #category : #playing }
SpaceGame >> playTurnOfSpaceship: aSpaceShip [

	| diceCupRoll |
	self isFinished ifTrue: [ ^ self ].
	diceCupRoll := diceCup roll.
	self updatePositionOf: aSpaceShip afterRolling: diceCupRoll
]

{ #category : #accessing }
SpaceGame >> positionOfSpaceship: aSpaceShip [

	^ (self obtainSpaceShipStatusFrom: aSpaceShip) position
]

{ #category : #playing }
SpaceGame >> updatePositionOf: aSpaceShip afterRolling: diceCupRoll [

	| currentSpaceShipStatus newPosition |
	currentSpaceShipStatus := self obtainSpaceShipStatusFrom: aSpaceShip.
	newPosition := board
		               obtainPositionStartingIn:
		               currentSpaceShipStatus position
		               afterRolling: diceCupRoll.
	newPosition = board positions ifTrue: [ 
		winner newWinnerBecomes: aSpaceShip ].
	currentSpaceShipStatus updateSpaceShipPositionWith: newPosition
]

{ #category : #accessing }
SpaceGame >> winner [
	^self assertWinnerExists
	
]
