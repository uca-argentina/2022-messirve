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
MessirveSpaceRaceGame >> advanceCurrentSpaceShipTo: newPosition and: newLap [

	| newStatus |
	self assertMovementCanBeApplied.
	newStatus := SpaceShipStatus
		             with: self nameOfSpaceShipPlaying
		             placedAt: newPosition
		             on: newLap.
	spaceshipStatuses
		replaceAll: self currentSpaceShipStatus
		with: newStatus
]

{ #category : #private }
MessirveSpaceRaceGame >> advanceToNextTurn [

	currentTurn := spaceShipSequence nextSequenceTurnNumber.
	self isFinished ifFalse: [ 
		gameStatus := MessirveSpaceGameStartOfTurnStatus new ]
]

{ #category : #private }
MessirveSpaceRaceGame >> applyBoostOf: aBoost [

	self
		advanceCurrentSpaceShipTo: (self calculateNewPositionOfCurrentSpaceShipAfter: aBoost)
		and: (self calculateNewLapOfCurrentSpaceShipAfter: aBoost)
]

{ #category : #private }
MessirveSpaceRaceGame >> applyMoonWalkEffectWith: anN [

	| currentSpaceShipPosition currentSpaceShipLap |
	self assertMovementCanBeApplied.
	currentSpaceShipPosition := self positionOfSpaceship:
		                            self nameOfSpaceShipPlaying.
	currentSpaceShipLap := self lapsOfSpaceship:
		                       self nameOfSpaceShipPlaying.


	spaceshipStatuses := spaceshipStatuses collect: [ :status | 
		                     SpaceShipStatus
			                     with: status spaceShip
			                     placedAt:
			                     (board
				                      finalPositionWhenStartingAt: status position
				                      afterRolling: anN)
			                     on: status lap ].

	self
		advanceCurrentSpaceShipTo: currentSpaceShipPosition
		and: currentSpaceShipLap
]

{ #category : #private }
MessirveSpaceRaceGame >> applyMovementToCurrentSpaceShipAfterRolling: diceCupRoll [

	| newPositionBeforeEffect newLapBeforeEffect effecLanded |
	self assertMovementCanBeApplied.
	newPositionBeforeEffect := self 
		                           calculateNewPositionOfCurrentSpaceShipAfter:
		                           diceCupRoll.
	newLapBeforeEffect := self calculateNewLapOfCurrentSpaceShipAfter:
		                      diceCupRoll.
	self
		advanceCurrentSpaceShipTo: newPositionBeforeEffect
		and: newLapBeforeEffect.
	effecLanded := board effectAppliedOnPosition: newPositionBeforeEffect.
	effecLanded applyEffectOn: self.
	self verifyWinner
]

{ #category : #'as yet unclassified' }
MessirveSpaceRaceGame >> applyNukeEffect [

	self assertMovementCanBeApplied.
	spaceshipStatuses := spaceshipStatuses collect: [ :status | 
		                     SpaceShipStatus
			                     with: status spaceShip
			                     placedAt: 1
			                     on: status lap ]
]

{ #category : #private }
MessirveSpaceRaceGame >> assertGameIsNotFinished [

	self isFinished ifTrue: [ 
		Error signal: 'A game cannot be played after it has finished' ]
]

{ #category : #asserting }
MessirveSpaceRaceGame >> assertMovementCanBeApplied [

	gameStatus canApplyMovement ifFalse: [ 
		Error signal: 'Movement cannot be applied before the roll' ]
]

{ #category : #initialization }
MessirveSpaceRaceGame >> assignSpaceshipStatusesFrom: spaceShipsNames [

	| initialPosition |

	initialPosition := board startingPosition.
	
	spaceshipStatuses := spaceShipsNames asOrderedCollection collect: [ :aSpaceShip | 
		                     SpaceShipStatus with: aSpaceShip placedAt: initialPosition on: 1] 
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
	gameStatus := MessirveSpaceGameStartOfTurnStatus new.
	spaceShipSequence := SpaceShipSequence formedByAmountOfSpaceShips:
		                     spaceShipsNames
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

{ #category : #'as yet unclassified' }
MessirveSpaceRaceGame >> parsecsPerPosition [
	^board parsecsPerPosition.
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
