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
		'lapsToWin',
		'ranking'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #verification }
MessirveSpaceRaceGame class >> assertPlayerNameNotDuplicated: spaceShips [

	| spaceShipsSetSize spaceShipsSize |
	spaceShipsSize := spaceShips asOrderedCollection size.
	spaceShipsSetSize := spaceShips asSet size.

	spaceShipsSetSize == spaceShipsSize ifFalse: [ 
		Error signal: 'SpaceShip name duplicated' ]
]

{ #category : #initialization }
MessirveSpaceRaceGame class >> playedBy: spaceShips on: aBoard rolling: aDiceCup withLapsToWin: anAmountOfLaps [

	self assertPlayerNameNotDuplicated: spaceShips.
	^ self new
		  initiallizePlayedBy: spaceShips
		  on: aBoard
		  rolling: aDiceCup
		  withLapsToWin: anAmountOfLaps
]

{ #category : #private }
MessirveSpaceRaceGame >> applyMovementToCurrentSpaceShipAfterRolling: diceCupRoll [

	self assertMovementCanBeApplied.
	spaceshipStatuses := board
		                     newStatusesFrom: spaceshipStatuses
		                     afterA: diceCupRoll
		                     from: self currentSpaceShipStatus
		                     on: self.
	self endTheGameIfAWinnerExists
]

{ #category : #private }
MessirveSpaceRaceGame >> assertGameIsNotFinished [

	self isFinished ifTrue: [ 
		Error signal: 'A game cannot be played after it has finished' ]
]

{ #category : #verification }
MessirveSpaceRaceGame >> assertMovementCanBeApplied [

	gameStatus canApplyMovement ifFalse: [ 
		Error signal: 'Movement cannot be applied before the roll' ]
]

{ #category : #asserting }
MessirveSpaceRaceGame >> assertPermanentPlayedOnCorrectlyBy: cardPlayer [

	cardPlayer = self nameOfSpaceShipPlaying ifFalse: [ 
		Error signal:
			'Permanent cards can only be played during the turn of a Spaceship' ]
]

{ #category : #initialization }
MessirveSpaceRaceGame >> assignSpaceshipStatusesFrom: spaceShipsNames [

	| initialPosition |
	initialPosition := board startingPosition.

	spaceshipStatuses := spaceShipsNames collect: [ :aSpaceShip | 
		                     SpaceShipStatus
			                     with: aSpaceShip
			                     and:
			                     (SpaceShipPosition
				                      with: initialPosition
				                      and: 1
				                      on: board) ]
]

{ #category : #private }
MessirveSpaceRaceGame >> calculateNewRanking [

	ranking := spaceshipStatuses copy.

	ranking sort: [ :aSpaceShip : anotherSpaceShip | 
		aSpaceShip position >= anotherSpaceShip position ].
]

{ #category : #private }
MessirveSpaceRaceGame >> currentSpaceShipStatus [

	| currentSpaceShipStatus |
	currentSpaceShipStatus := self obtainSpaceShipStatusFrom:
		                          self nameOfSpaceShipPlaying.
	^ currentSpaceShipStatus
]

{ #category : #private }
MessirveSpaceRaceGame >> endTheGameIfAWinnerExists [

	self winnerExists ifFalse: [ ^ self ].
	gameStatus := MessirveSpaceGameFinishedStatus withWinner:
		              self nameOfSpaceShipPlaying
]

{ #category : #initialization }
MessirveSpaceRaceGame >> initiallizePlayedBy: spaceShipsNames on: aBoard rolling: aDiceCup withLapsToWin: anAmountOfLaps [

	board := aBoard.
	self assignSpaceshipStatusesFrom: spaceShipsNames.
	board initialSetUpWith: spaceShipsNames.
	diceCup := aDiceCup.
	lapsToWin := anAmountOfLaps.
	currentTurn := 1.
	ranking := spaceshipStatuses.
	gameStatus := MessirveSpaceGameStartOfTurnStatus new.
	spaceShipSequence := Sequence formedBy: spaceShipsNames
]

{ #category : #accessing }
MessirveSpaceRaceGame >> inventoryFrom: aSpaceShipName [

	^ board cardsInInventoryOf: aSpaceShipName
]

{ #category : #testing }
MessirveSpaceRaceGame >> isFinished [

	^ gameStatus isFinished
]

{ #category : #accessing }
MessirveSpaceRaceGame >> lapsOfSpaceship: aSpaceShip [

	^ (self obtainSpaceShipStatusFrom: aSpaceShip) lap
]

{ #category : #accessing }
MessirveSpaceRaceGame >> lapsToWin [

	^ lapsToWin
]

{ #category : #private }
MessirveSpaceRaceGame >> nameOfSpaceShipPlaying [

	^ (spaceshipStatuses at: currentTurn) spaceShip
]

{ #category : #private }
MessirveSpaceRaceGame >> nextTurn [

	currentTurn := spaceShipSequence next.
	self isFinished ifFalse: [ 
		gameStatus := MessirveSpaceGameStartOfTurnStatus new ]
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
	gameStatus := MessirveSpaceGameTurnInProgressStatus new.
	self applyMovementToCurrentSpaceShipAfterRolling: diceCupRoll.
	self nextTurn
]

{ #category : #accessing }
MessirveSpaceRaceGame >> positionOfSpaceship: aSpaceShip [

	^ (self obtainSpaceShipStatusFrom: aSpaceShip) tile
]

{ #category : #accessing }
MessirveSpaceRaceGame >> ranking [

	^ ranking
]

{ #category : #'as yet unclassified' }
MessirveSpaceRaceGame >> spaceShip: cardPlayer plays: aCard on: cardTarget [

	board
		spaceShip: cardPlayer
		plays: aCard
		on: cardTarget
		from: self
]

{ #category : #accessing }
MessirveSpaceRaceGame >> winner [

	^ gameStatus winner
]

{ #category : #private }
MessirveSpaceRaceGame >> winnerExists [

	^ spaceshipStatuses anySatisfy: [ :status | status lap = lapsToWin ]
]
