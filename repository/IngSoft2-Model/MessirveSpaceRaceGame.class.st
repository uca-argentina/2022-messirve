Class {
	#name : #MessirveSpaceRaceGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCup',
		'spaceshipStatuses',
		'currentTurn',
		'gameStatus',
		'spaceShipSequence',
		'lapsToWin'
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

{ #category : #'as yet unclassified' }
MessirveSpaceRaceGame class >> playedBy: spaceShips on: aBoard rolling: aDiceCup with: anAmountOfLaps [

	self assertPlayerNameNotDuplicated: spaceShips.
	^ self new initiallizePlayedBy: spaceShips on: aBoard rolling: aDiceCup with: anAmountOfLaps 
]

{ #category : #private }
MessirveSpaceRaceGame >> advanceToNextTurn [

	currentTurn := spaceShipSequence nextSequenceTurnNumber.

]

{ #category : #private }
MessirveSpaceRaceGame >> applyMovementTo: aSpaceShip afterRolling: diceCupRoll [

	| currentSpaceShipStatus newPosition newStatus newLap |
	currentSpaceShipStatus := self obtainSpaceShipStatusFrom: aSpaceShip.
	newPosition := board
		               finalPositionWhenStartingAt:
		               currentSpaceShipStatus position
		               afterRolling: diceCupRoll.
	newLap := self newLapsOfCurrentSpaceshipAfterRolling: diceCupRoll.
	newStatus := SpaceShipStatus
		             with: aSpaceShip
		             placedAt: newPosition
		             on: newLap.
	spaceshipStatuses replaceAll: currentSpaceShipStatus with: newStatus.
	self winnerExists ifFalse: [ ^ self ].
	gameStatus := MessirveSpaceGameFinishedStatus withWinner: aSpaceShip
]

{ #category : #private }
MessirveSpaceRaceGame >> assertGameIsNotFinished [

	self isFinished ifTrue: [ 
		Error signal: 'A game cannot be played after it has finished' ]
]

{ #category : #initialization }
MessirveSpaceRaceGame >> assignSpaceshipStatusesFrom: spaceShipsNames [

	| initialPosition |

	initialPosition := board startingPosition.
	
	spaceshipStatuses := spaceShipsNames asOrderedCollection collect: [ :aSpaceShip | 
		                     SpaceShipStatus with: aSpaceShip placedAt: initialPosition on: 0] 
]

{ #category : #initialization }
MessirveSpaceRaceGame >> initiallizePlayedBy: spaceShipsNames on: aBoard rolling: aDiceCup [

	board := aBoard.
	diceCup := aDiceCup.
	currentTurn := 1.
	self assignSpaceshipStatusesFrom: spaceShipsNames.
	gameStatus := MessirveSpaceGameInProgressStatus new. 
	spaceShipSequence := SpaceShipSequence formedByAmountOfSpaceShips: spaceShipsNames.
]

{ #category : #'as yet unclassified' }
MessirveSpaceRaceGame >> initiallizePlayedBy: spaceShipsNames on: aBoard rolling: aDiceCup with: anAmountOfLaps [

	board := aBoard.
	diceCup := aDiceCup.
	lapsToWin := anAmountOfLaps.
	currentTurn := 1.
	self assignSpaceshipStatusesFrom: spaceShipsNames.
	gameStatus := MessirveSpaceGameInProgressStatus new. 
	spaceShipSequence := SpaceShipSequence formedByAmountOfSpaceShips: spaceShipsNames.
]

{ #category : #testing }
MessirveSpaceRaceGame >> isFinished [
	^gameStatus isFinished .
]

{ #category : #'as yet unclassified' }
MessirveSpaceRaceGame >> lapsOfSpaceship: aSpaceShip [

	^ (self obtainSpaceShipStatusFrom: aSpaceShip) lap
]

{ #category : #private }
MessirveSpaceRaceGame >> nameOfSpaceShipPlaying [

	^ (spaceshipStatuses at: currentTurn) spaceShip
]

{ #category : #'instance creation' }
MessirveSpaceRaceGame >> newLapsOfCurrentSpaceshipAfterRolling: diceCupRoll [

	| newLaps currentLaps lapsToAdd positionOfSpaceship |
	
	currentLaps := self lapsOfSpaceship:  (self nameOfSpaceShipPlaying ).
		
	positionOfSpaceship:= self positionOfSpaceship:
			             ((spaceshipStatuses at: currentTurn) spaceShip).
			
	lapsToAdd := (positionOfSpaceship + diceCupRoll) // board positions.

	newLaps := currentLaps + lapsToAdd.
	^newLaps := newLaps min: lapsToWin
]

{ #category : #private }
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

{ #category : #private }
MessirveSpaceRaceGame >> winnerExists [

	^ spaceshipStatuses anySatisfy: [ :status | status lap = lapsToWin ]
]
