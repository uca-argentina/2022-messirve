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
	
	spaceShipsSize := (spaceShips asOrderedCollection) size.
	spaceShipsSetSize := (spaceShips asSet) size. 
	
	(spaceShipsSetSize == spaceShipsSize)
	ifFalse: [ Error signal: 'SpaceShip name duplicated' ].
	
	
	
]

{ #category : #initialization }
MessirveSpaceRaceGame class >> playedBy: spaceShips on: aBoard rolling: aDiceCup withLapsToWin: anAmountOfLaps [

	self assertPlayerNameNotDuplicated: spaceShips.
	^ self new initiallizePlayedBy: spaceShips on: aBoard rolling: aDiceCup withLapsToWin: anAmountOfLaps 
]

{ #category : #private }
MessirveSpaceRaceGame >> advanceCurrentSpaceShipTo: aSpaceShipDistance [

	| newStatus |
	self assertMovementCanBeApplied.
	newStatus := SpaceShipStatus
		             with: self nameOfSpaceShipPlaying
		             and: aSpaceShipDistance.
	spaceshipStatuses
		replaceAll: self currentSpaceShipStatus
		with: newStatus
]

{ #category : #private }
MessirveSpaceRaceGame >> advanceToNextTurn [

	currentTurn := spaceShipSequence advanceSequenceNumber.
	self isFinished ifFalse: [ 
		gameStatus := MessirveSpaceGameStartOfTurnStatus new ]
]

{ #category : #private }
MessirveSpaceRaceGame >> applyAtomicBombEffect [

	self assertMovementCanBeApplied.
	spaceshipStatuses := spaceshipStatuses collect: [ :status | 
		                     SpaceShipStatus
			                     with: status spaceShip
			                     and:
			                     (SpaceShipDistance
				                      with: 1
				                      and: status lap
				                      on: board) ]
]

{ #category : #private }
MessirveSpaceRaceGame >> applyBoostOf: aBoost [

	self advanceCurrentSpaceShipTo:
		(self calculateNewDistanceAfter: aBoost)
]

{ #category : #private }
MessirveSpaceRaceGame >> applyMoonWalkEffectWith: anN [

	| currentDistance |
	self assertMovementCanBeApplied.
	currentDistance := self currentSpaceShipStatus distance.

	spaceshipStatuses := spaceshipStatuses collect: [ :status | 
		                     SpaceShipStatus
			                     with: status spaceShip
			                     and: (SpaceShipDistance
					                      with:
					                      (board
						                       finalPositionWhenStartingAt:
						                       status position
						                       afterRolling: anN)
					                      and: status lap
					                      on: board) ].

	self advanceCurrentSpaceShipTo: currentDistance
]

{ #category : #private }
MessirveSpaceRaceGame >> applyMovementToCurrentSpaceShipAfterRolling: diceCupRoll [

	| effecLanded newDistance |
	self assertMovementCanBeApplied.
	newDistance := self calculateNewDistanceAfter: diceCupRoll.
	self advanceCurrentSpaceShipTo: newDistance.
	effecLanded := board effectAppliedOnPosition: newDistance position.
	effecLanded applyEffectOn: self.
	self verifyWinner
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

{ #category : #initialization }
MessirveSpaceRaceGame >> assignSpaceshipStatusesFrom: spaceShipsNames [

	| initialPosition |
	initialPosition := board startingPosition.

	spaceshipStatuses := spaceShipsNames asOrderedCollection collect: [ 
		                     :aSpaceShip | 
		                     SpaceShipStatus
			                     with: aSpaceShip
			                     and:
			                     (SpaceShipDistance
				                      with: initialPosition
				                      and: 1
				                      on: board) ]
]

{ #category : #private }
MessirveSpaceRaceGame >> calculateNewDistanceAfter: aMovement [

	| aPosition aLap |
	aPosition := self calculateNewPositionOfCurrentSpaceShipAfter:
		             aMovement.
	aLap := self calculateNewLapOfCurrentSpaceShipAfter: aMovement.

	^ SpaceShipDistance with: aPosition and: aLap on: board
]

{ #category : #private }
MessirveSpaceRaceGame >> calculateNewLapOfCurrentSpaceShipAfter: aMovement [

	| newLaps currentLaps lapsToAdd positionOfSpaceship |
	self assertMovementCanBeApplied.
	currentLaps := self lapsOfSpaceship: self nameOfSpaceShipPlaying.

	positionOfSpaceship := self positionOfSpaceship:
		                       (spaceshipStatuses at: currentTurn) spaceShip.

	lapsToAdd := positionOfSpaceship + aMovement // board lastPosition.

	newLaps := currentLaps + lapsToAdd.

	newLaps > lapsToWin
		ifTrue: [ ^ lapsToWin ]
		ifFalse: [ 
			newLaps < 1
				ifTrue: [ ^ 1 ]
				ifFalse: [ ^ newLaps ] ]
]

{ #category : #private }
MessirveSpaceRaceGame >> calculateNewPositionOfCurrentSpaceShipAfter: aMovement [

	| newPosition |
	newPosition := board
		               finalPositionWhenStartingAt:
		               self currentSpaceShipStatus position
		               afterRolling: aMovement.
	^ newPosition
]

{ #category : #private }
MessirveSpaceRaceGame >> calculateNewRanking [

	ranking := spaceshipStatuses collect: [ :a | a ].

	ranking sort: [ :a :b | 
		a distance totalTraveled >= b distance totalTraveled ]
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
	ranking := spaceshipStatuses.
	gameStatus := MessirveSpaceGameStartOfTurnStatus new.
	spaceShipSequence := SequenceValidator formedBy:
		                     spaceShipsNames
]

{ #category : #testing }
MessirveSpaceRaceGame >> isFinished [

	^ gameStatus isFinished
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

{ #category : #accessing }
MessirveSpaceRaceGame >> parsecsPerPosition [

	^ board parsecsPerPosition
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
	self calculateNewRanking.
	self advanceToNextTurn
]

{ #category : #accessing }
MessirveSpaceRaceGame >> positionOfSpaceship: aSpaceShip [

	^ (self obtainSpaceShipStatusFrom: aSpaceShip) position
]

{ #category : #accessing }
MessirveSpaceRaceGame >> ranking [
	^ranking.
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
