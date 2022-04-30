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
MessirveSpaceRaceGame >> assertValidRoundBeingPlayed [

	self isFinished ifTrue: [ 
		Error signal: 'A round cannot be played after the game has finished' ]
]

{ #category : #asserting }
MessirveSpaceRaceGame >> assertWinnerExists [
	winner winnerExists
	ifTrue: [ ^winner spaceShipWinner ]
	ifFalse: [ Error signal: 'There is no winner since the game has not finished' ]
]

{ #category : #initialization }
MessirveSpaceRaceGame >> assignSpaceshipStatusesFrom: spaceShipsNames [

	| spaceShips initialPosition |
	spaceShips := spaceShipsNames collect: [ :name | 
		              SpaceShip withName: name ].
	
	initialPosition := board startingPosition.
	
	spaceshipStatuses := spaceShips collect: [ :aSpaceShip | 
		                     SpaceShipStatus with: aSpaceShip placedAt: initialPosition ]
]

{ #category : #playing }
MessirveSpaceRaceGame >> finalPositionWhenStartingAt: aSpaceShip afterRolling: diceCupRoll [

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

{ #category : #testing }
MessirveSpaceRaceGame >> isFinished [
	^winner winnerExists.
]

{ #category : #playing }
MessirveSpaceRaceGame >> nextSpaceShipPlaying [
	self shouldBeImplemented.
]

{ #category : #playing }
MessirveSpaceRaceGame >> obtainSpaceShipStatusFrom: aSpaceShip [

	^ spaceshipStatuses detect: [ :status | 
		  status spaceShip name == aSpaceShip ]
]

{ #category : #playing }
MessirveSpaceRaceGame >> playGame [

	self isFinished
		ifFalse: [ self playRound ]
		ifTrue: [ 
		Error signal: 'Game cannot be played since it is finished' ].
]

{ #category : #playing }
MessirveSpaceRaceGame >> playNextTurn [

	| diceCupRoll |
	self isFinished ifTrue: [ ^ self ].

	diceCupRoll := diceCup roll.
	self finalPositionWhenStartingAt: ((spaceshipStatuses at: currentTurn) spaceShip name) afterRolling: diceCupRoll.
	self advanceToNextTurn.
]

{ #category : #playing }
MessirveSpaceRaceGame >> playRound [

	self assertValidRoundBeingPlayed.

	spaceshipStatuses do: [ :status | self playNextTurn ].

	self isFinished ifFalse: [ self playRound ]
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
