Class {
	#name : #MessirveSpaceRaceGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'spaceshipStatuses',
		'winner',
		'currentTurn'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
MessirveSpaceRaceGame class >> assertPlayerNameNotDuplicated: spaceShips [ 

	| spaceShipsSetSize spaceShipsSize |
	
	spaceShipsSize := (spaceShips asOrderedCollection) size.
	spaceShipsSetSize := (spaceShips asSet) size. 
	
	(spaceShipsSetSize == spaceShipsSize)
	ifFalse: [ Error signal: 'Player name duplicated' ].
	
	
	
]

{ #category : #initialization }
MessirveSpaceRaceGame class >> playedBy: spaceShips on: aBoard rolling: aDiceCup [

	self assertPlayerNameNotDuplicated: spaceShips.
	^ self new playedBy: spaceShips on: aBoard rolling: aDiceCup
]

{ #category : #accessing }
MessirveSpaceRaceGame >> advanceToNextTurn [

	currentTurn := currentTurn == spaceshipStatuses size
		               ifTrue: [ 1 ]
		               ifFalse: [ currentTurn + 1 ]
]

{ #category : #playing }
MessirveSpaceRaceGame >> applyMovementTo: aSpaceShip afterRolling: diceCupRoll [

	| currentSpaceShipStatus newPosition newStatus|
	currentSpaceShipStatus := self obtainSpaceShipStatusFrom: aSpaceShip.

	newPosition := board
		               finalPositionWhenStartingAt:
		               currentSpaceShipStatus position
		               afterRolling: diceCupRoll.
	
	newStatus := SpaceShipStatus with: aSpaceShip placedAt: newPosition. 
	spaceshipStatuses at: currentTurn put: newStatus. 
		
	newPosition = board positions ifTrue: [ 
		winner newWinnerBecomes: aSpaceShip ].

	
]

{ #category : #playing }
MessirveSpaceRaceGame >> assertGameIsNotFinished [

	self isFinished ifTrue: [ 
		Error signal: 'A game cannot be played after it has finished' ]
]

{ #category : #asserting }
MessirveSpaceRaceGame >> assertWinnerExists [
	winner winnerExists
	ifTrue: [ ^winner spaceShipWinner ]
	ifFalse: [ Error signal: 'There is no winner since the game has not finished' ]
]

{ #category : #initialization }
MessirveSpaceRaceGame >> assignSpaceshipStatusesFrom: spaceShipsNames [

	| initialPosition |

	initialPosition := board startingPosition.
	
	spaceshipStatuses := spaceShipsNames collect: [ :aSpaceShip | 
		                     SpaceShipStatus with: aSpaceShip placedAt: initialPosition ]
]

{ #category : #testing }
MessirveSpaceRaceGame >> isFinished [
	^winner winnerExists.
]

{ #category : #playing }
MessirveSpaceRaceGame >> nameOfSpaceShipPlaying [

	^ (spaceshipStatuses at: currentTurn) spaceShip
]

{ #category : #playing }
MessirveSpaceRaceGame >> obtainSpaceShipStatusFrom: aSpaceShip [

	^ spaceshipStatuses detect: [ :status | 
		  status spaceShip == aSpaceShip ]
]

{ #category : #playing }
MessirveSpaceRaceGame >> playGame [

	self assertGameIsNotFinished.
	self playNextTurn.
	self isFinished ifFalse: [ self playGame ]
]

{ #category : #playing }
MessirveSpaceRaceGame >> playNextTurn [

	| diceCupRoll |
	self assertGameIsNotFinished.

	diceCupRoll := diceCup roll.
	self
		applyMovementTo: self nameOfSpaceShipPlaying
		afterRolling: diceCupRoll.
	self advanceToNextTurn
]

{ #category : #initialization }
MessirveSpaceRaceGame >> playedBy: spaceShipsNames on: aBoard rolling: aDiceCup [

	board := aBoard.
	diceCup := aDiceCup.
	winner := SpaceShipWinner initializeWithoutWinner.
	currentTurn := 1.
	self assignSpaceshipStatusesFrom: spaceShipsNames
]

{ #category : #accessing }
MessirveSpaceRaceGame >> positionOfSpaceship: aSpaceShip [

	^ (self obtainSpaceShipStatusFrom: aSpaceShip) position
]

{ #category : #accessing }
MessirveSpaceRaceGame >> winner [
	^self assertWinnerExists
	
]
