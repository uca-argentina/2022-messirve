Class {
	#name : #MessirveSpaceRaceGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'spaceshipStatuses',
		'currentTurn',
		'gameStatus'
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
	^ self new initiallizePlayedBy: spaceShips on: aBoard rolling: aDiceCup
]

{ #category : #accessing }
MessirveSpaceRaceGame >> advanceToNextTurn [

	currentTurn := currentTurn == spaceshipStatuses size
		               ifTrue: [ 1 ]
		               ifFalse: [ currentTurn + 1 ]
]

{ #category : #playing }
MessirveSpaceRaceGame >> applyMovementTo: aSpaceShip afterRolling: diceCupRoll [

	| currentSpaceShipStatus newPosition newStatus |
	currentSpaceShipStatus := self obtainSpaceShipStatusFrom: aSpaceShip.
	newPosition := board
		               finalPositionWhenStartingAt:
		               currentSpaceShipStatus position
		               afterRolling: diceCupRoll.
	newStatus := SpaceShipStatus with: aSpaceShip placedAt: newPosition.
	spaceshipStatuses replaceAll: currentSpaceShipStatus with: newStatus.

	newPosition = board positions ifFalse: [ ^ self ].
	gameStatus := MessirveSpaceGameFinishedStatus withWinner: aSpaceShip.
]

{ #category : #playing }
MessirveSpaceRaceGame >> assertGameIsNotFinished [

	self isFinished ifTrue: [ 
		Error signal: 'A game cannot be played after it has finished' ]
]

{ #category : #initialization }
MessirveSpaceRaceGame >> assignSpaceshipStatusesFrom: spaceShipsNames [

	| initialPosition |

	initialPosition := board startingPosition.
	
	spaceshipStatuses := spaceShipsNames asOrderedCollection collect: [ :aSpaceShip | 
		                     SpaceShipStatus with: aSpaceShip placedAt: initialPosition ] 
]

{ #category : #initialization }
MessirveSpaceRaceGame >> initiallizePlayedBy: spaceShipsNames on: aBoard rolling: aDiceCup [

	board := aBoard.
	diceCup := aDiceCup.
	currentTurn := 1.
	self assignSpaceshipStatusesFrom: spaceShipsNames.
	gameStatus := MessirveSpaceGameInProgressStatus new . 
]

{ #category : #testing }
MessirveSpaceRaceGame >> isFinished [
	^gameStatus isFinished .
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

{ #category : #accessing }
MessirveSpaceRaceGame >> positionOfSpaceship: aSpaceShip [

	^ (self obtainSpaceShipStatusFrom: aSpaceShip) position
]

{ #category : #accessing }
MessirveSpaceRaceGame >> winner [
	^gameStatus winner.
	
]
