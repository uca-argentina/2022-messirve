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
MessirveSpaceRaceGame class >> playedBy: spaceShips on: aBoard rolling: aDiceCup withLapsToWin: anAmountOfLaps [

	self assertPlayerNameNotDuplicated: spaceShips.
	^ self new initiallizePlayedBy: spaceShips on: aBoard rolling: aDiceCup withLapsToWin: anAmountOfLaps 
]

{ #category : #private }
MessirveSpaceRaceGame >> advanceToNextTurn [

	currentTurn := spaceShipSequence nextSequenceTurnNumber.

]

{ #category : #private }
MessirveSpaceRaceGame >> applyMovementToCurrentSpaceShipAfterRolling: diceCupRoll [

	| newPosition newStatus newLap |
	newPosition := self calculateNewPositionAfter: diceCupRoll.
	newLap := self calculateNewLapOfCurrentSpaceshipAfterRolling:
		          diceCupRoll.
	newStatus := SpaceShipStatus
		             with: self nameOfSpaceShipPlaying
		             placedAt: newPosition
		             on: newLap.
	spaceshipStatuses
		replaceAll: self currentSpaceShipStatus
		with: newStatus.
	self verifyWinner
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
		                     SpaceShipStatus with: aSpaceShip placedAt: initialPosition on: 1] 
]

{ #category : #'instance creation' }
MessirveSpaceRaceGame >> calculateNewLapOfCurrentSpaceshipAfterRolling: diceCupRoll [

	| newLaps currentLaps lapsToAdd positionOfSpaceship |
	
	currentLaps := self lapsOfSpaceship:  (self nameOfSpaceShipPlaying ).
		
	positionOfSpaceship:= self positionOfSpaceship:
			             ((spaceshipStatuses at: currentTurn) spaceShip).
			
	lapsToAdd := (positionOfSpaceship + diceCupRoll) // board lastPosition.

	newLaps := currentLaps + lapsToAdd.
	^newLaps := newLaps min: lapsToWin
]

{ #category : #private }
MessirveSpaceRaceGame >> calculateNewPositionAfter: diceCupRoll [

	| newPosition |
	newPosition := board
		               finalPositionWhenStartingAt:
		               self currentSpaceShipStatus position
		               afterRolling: diceCupRoll.
	^ newPosition
]

{ #category : #private }
MessirveSpaceRaceGame >> currentSpaceShipStatus [

	| currentSpaceShipStatus |
	currentSpaceShipStatus := self obtainSpaceShipStatusFrom:
		                          self nameOfSpaceShipPlaying.
	^ currentSpaceShipStatus
]

{ #category : #initialization }
MessirveSpaceRaceGame >> initiallizePlayedBy: spaceShipsNames on: aBoard rolling: aDiceCup withLapsToWin: anAmountOfLaps [

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

{ #category : #accessing }
MessirveSpaceRaceGame >> lapsOfSpaceship: aSpaceShip [

	^ (self obtainSpaceShipStatusFrom: aSpaceShip) lap
]

{ #category : #private }
MessirveSpaceRaceGame >> nameOfSpaceShipPlaying [

	^ (spaceshipStatuses at: currentTurn) spaceShip
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
		applyMovementToCurrentSpaceShipAfterRolling: diceCupRoll.
	self advanceToNextTurn
]

{ #category : #accessing }
MessirveSpaceRaceGame >> positionOfSpaceship: aSpaceShip [

	^ (self obtainSpaceShipStatusFrom: aSpaceShip) position
]

{ #category : #private }
MessirveSpaceRaceGame >> verifyWinner [

	self winnerExists ifFalse: [ ^ self ].
	gameStatus := MessirveSpaceGameFinishedStatus withWinner:
		              self nameOfSpaceShipPlaying
]

{ #category : #accessing }
MessirveSpaceRaceGame >> winner [
	^gameStatus winner.
	
]

{ #category : #private }
MessirveSpaceRaceGame >> winnerExists [

	^ spaceshipStatuses anySatisfy: [ :status | status lap = lapsToWin ]
]
