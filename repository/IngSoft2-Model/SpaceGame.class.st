Class {
	#name : #SpaceGame,
	#superclass : #Object,
	#instVars : [
		'gameIsFinished',
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

{ #category : #initialization }
SpaceGame >> assignSpaceshipStatusesFrom: spaceShipsNames [

	| spaceShips |
	spaceShips := spaceShipsNames collect: [ :name | 
		              SpaceShip withName: name ].
	spaceshipStatuses := spaceShips collect: [ :aSpaceShip | 
		                     SpaceShipStatus with: aSpaceShip ]
]

{ #category : #initialization }
SpaceGame >> initializeWithBoard: aBoard diceCup: aDiceCup andSpaceShips: spaceShipsNames [

	gameIsFinished := false.
	board := aBoard.
	diceCup := aDiceCup.
	self assignSpaceshipStatusesFrom: spaceShipsNames
]

{ #category : #testing }
SpaceGame >> isFinished [
	^ winner isNotNil.
]

{ #category : #playing }
SpaceGame >> playGame [

	self playRound.

	self isFinished ifFalse: [ self playGame ]
]

{ #category : #playing }
SpaceGame >> playRound [
	spaceshipStatuses do: [ : status | self playTurnOfSpaceship: (status spaceShip name)].
]

{ #category : #playing }
SpaceGame >> playTurnOfSpaceship: aSpaceShip [

	| diceCupRoll |
	self isFinished ifTrue: [ ^ self ].
	diceCupRoll := diceCup roll.
	self updatePositionOf: aSpaceShip afterRolling: diceCupRoll
]

{ #category : #'accessing - variables' }
SpaceGame >> positionOfSpaceship: aSpaceShip [ 
	
	^ (spaceshipStatuses detect: [ : status | status spaceShip name == aSpaceShip]) position.
]

{ #category : #setter }
SpaceGame >> setWinner: aSpaceShipName [ 
	winner := aSpaceShipName.
]

{ #category : #accessing }
SpaceGame >> spaceShipStatuses [
	^spaceshipStatuses
]

{ #category : #playing }
SpaceGame >> updatePositionOf: aSpaceShip afterRolling: diceCupRoll [

	| currentSpaceShipStatus newPosition |
	currentSpaceShipStatus := spaceshipStatuses detect: [ :status | 
		                          status spaceShip name == aSpaceShip ].
	newPosition := board
		               obtainPositionStartingIn:
		               currentSpaceShipStatus position
		               afterRolling: diceCupRoll.
	newPosition >= board positions ifTrue: [ self setWinner: aSpaceShip ].
	currentSpaceShipStatus updateSpaceShipPositionWith: newPosition
]

{ #category : #accessing }
SpaceGame >> winner [
	^ winner
]
