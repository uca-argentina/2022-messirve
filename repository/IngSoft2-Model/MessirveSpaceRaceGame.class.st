"
A space-themed race game where players compete to reach the finish line first.
"
Class {
	#name : 'MessirveSpaceRaceGame',
	#superclass : 'Object',
	#instVars : [
		'board',
		'diceCup',
		'spaceshipStatuses',
		'currentTurn',
		'gameStatus',
		'spaceShipSequence',
		'lapsToWin',
		'ranking',
		'cardApplicator'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'verification' }
MessirveSpaceRaceGame class >> assertPlayerNameNotDuplicated: spaceShips [

	| spaceShipsSetSize spaceShipsSize |
	spaceShipsSize := spaceShips asOrderedCollection size.
	spaceShipsSetSize := spaceShips asSet size.

	spaceShipsSetSize == spaceShipsSize ifFalse: [ 
		Error signal: 'SpaceShip name duplicated' ]
]

{ #category : 'as yet unclassified' }
MessirveSpaceRaceGame class >> playedBy: spaceShips on: aBoard rolling: aDiceCup withLapsToWin: anAmountOfLaps [

    self assertPlayerNameNotDuplicated: spaceShips.

    ^ self new
          initiallizePlayedBy: spaceShips
          on: aBoard
          rolling: aDiceCup
          withLapsToWin: anAmountOfLaps
          handing: self randomlyDistributedDeck
]

{ #category : 'initialization' }
MessirveSpaceRaceGame class >> playedBy: spaceShips on: aBoard rolling: aDiceCup withLapsToWin: anAmountOfLaps handing: cards [

	self assertPlayerNameNotDuplicated: spaceShips.
	^ self new
		  initiallizePlayedBy: spaceShips
		  on: aBoard
		  rolling: aDiceCup
		  withLapsToWin: anAmountOfLaps
		  handing: cards
]

{ #category : 'as yet unclassified' }
MessirveSpaceRaceGame class >> randomlyDistributedDeck [

    | source cancellationCard accelerationCard overloadCard speedCard redoCard repeatCard probabilityEvents discreteProbabilityDistribution |
    cancellationCard := CancellationCard new.
    accelerationCard := AccelerationCard new.
    overloadCard := OverloadCard new.
    speedCard := SpeedCard new.
    redoCard := RedoCard new.
    repeatCard := RepeatCard new.


    probabilityEvents := { 
                             (ProbabilityEvent
                                  of: cancellationCard
                                  with: 1 / 6).
                             (ProbabilityEvent
                                  of: accelerationCard
                                  with: 1 / 6).
                             (ProbabilityEvent of: overloadCard with: 1 / 6).
                             (ProbabilityEvent of: speedCard with: 1 / 6).
                             (ProbabilityEvent of: redoCard with: 1 / 6).
                             (ProbabilityEvent of: repeatCard with: 1 / 6) }.

    discreteProbabilityDistribution := DiscreteProbabilityDistribution 
                                           withAll: probabilityEvents.
    source := DiscreteProbabilityEventSource with:
                  discreteProbabilityDistribution.

    ^ source next: 100
]

{ #category : 'accessing' }
MessirveSpaceRaceGame >> activeCardsFrom: aSpaceShipName [ 

	^ cardApplicator activeCardsOf: aSpaceShipName
]

{ #category : 'private' }
MessirveSpaceRaceGame >> applyLastEffectTo: aSpaceShip [

	spaceshipStatuses := board
		                     applyLastEffectTo:
		                     (self obtainSpaceShipStatusFrom: aSpaceShip)
		                     from: spaceshipStatuses
		                     on: self
]

{ #category : 'private' }
MessirveSpaceRaceGame >> applyMovementTo: player afterRolling: diceCupRoll [

	| movement |
	movement := diceCupRoll
	            + (self enginePowerOf: self currentSpaceShipStatus).

	self assertMovementCanBeApplied.
		
	self moveSpaceShip: player toPosition: movement.
	
	self endTheGameIfAWinnerExists
]

{ #category : 'private' }
MessirveSpaceRaceGame >> assertGameIsNotFinished [

	self isFinished ifTrue: [ 
		Error signal: 'A game cannot be played after it has finished' ]
]

{ #category : 'verification' }
MessirveSpaceRaceGame >> assertMovementCanBeApplied [

	gameStatus canApplyMovement ifFalse: [ 
		Error signal: 'Movement cannot be applied before the roll' ]
]

{ #category : 'asserting' }
MessirveSpaceRaceGame >> assertPermanentPlayedOnCorrectlyBy: cardPlayer [

	cardPlayer = self nameOfSpaceShipPlaying ifFalse: [ 
		Error signal:
			'Permanent cards can only be played during the turn of a Spaceship' ]
]

{ #category : 'asserting' }
MessirveSpaceRaceGame >> assertTurnBelongsTo: player [
	
	|isCurrentPlayerTurn|
	
	isCurrentPlayerTurn := self currentSpaceShipStatus == player.
	isCurrentPlayerTurn ifTrue: [ ^ self ].
	self setPenalizationOf: -2 to: player.

]

{ #category : 'accessing' }
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

{ #category : 'private' }
MessirveSpaceRaceGame >> calculateNewRanking [

	ranking := spaceshipStatuses copy.

	ranking sort: [ :aSpaceShip : anotherSpaceShip | 
		aSpaceShip position >= anotherSpaceShip position ].
]

{ #category : 'accessing' }
MessirveSpaceRaceGame >> cardApplicator [

	^ cardApplicator
]

{ #category : 'private' }
MessirveSpaceRaceGame >> conductTheTurn [

	| diceCupRoll |
	diceCupRoll := diceCup roll.
	gameStatus := MessirveSpaceGameTurnInProgressStatus new.
	self
		applyMovementTo: self currentSpaceShipStatus
		afterRolling: diceCupRoll.
	self nextTurn
]

{ #category : 'private' }
MessirveSpaceRaceGame >> currentSpaceShipStatus [

	| currentSpaceShipStatus |
	currentSpaceShipStatus := self obtainSpaceShipStatusFrom:
		                          self nameOfSpaceShipPlaying.
	^ currentSpaceShipStatus
]

{ #category : 'private' }
MessirveSpaceRaceGame >> endTheGameIfAWinnerExists [

	self winnerExists ifFalse: [ ^ self ].
	gameStatus := MessirveSpaceGameFinishedStatus withWinner:
		              self nameOfSpaceShipPlaying
]

{ #category : 'accessing' }
MessirveSpaceRaceGame >> enginePowerOf: aSpaceShipStatus [

	^cardApplicator enginePowerOf: aSpaceShipStatus spaceShip
]

{ #category : 'action handling' }
MessirveSpaceRaceGame >> handlePenalizedPlayer [

	self setPenalizationOf: 0 to: self currentSpaceShipStatus.
	^ self nextTurn
]

{ #category : 'initialization' }
MessirveSpaceRaceGame >> initiallizePlayedBy: spaceShipsNames on: aBoard rolling: aDiceCup withLapsToWin: anAmountOfLaps handing: cards [

	board := aBoard.
	self assignSpaceshipStatusesFrom: spaceShipsNames.
	cardApplicator := CardApplicator handing: cards to: spaceShipsNames.
	diceCup := aDiceCup.
	lapsToWin := anAmountOfLaps.
	currentTurn := 1.
	ranking := spaceshipStatuses.
	gameStatus := MessirveSpaceGameStartOfTurnStatus new.
	spaceShipSequence := Sequence formedBy: spaceShipsNames.
	
]

{ #category : 'accessing' }
MessirveSpaceRaceGame >> inventoryFrom: aSpaceShipName [

	^ cardApplicator cardsInInventoryOf: aSpaceShipName
]

{ #category : 'testing' }
MessirveSpaceRaceGame >> isFinished [

	^ gameStatus isFinished
]

{ #category : 'accessing' }
MessirveSpaceRaceGame >> lapsOfSpaceship: aSpaceShip [

	^ (self obtainSpaceShipStatusFrom: aSpaceShip) lap
]

{ #category : 'accessing' }
MessirveSpaceRaceGame >> lapsToWin [

	^ lapsToWin
]

{ #category : 'private' }
MessirveSpaceRaceGame >> moveSpaceShip: player toPosition: movement [

	self assertTurnBelongsTo: player.

	spaceshipStatuses := board
		                     newStatusesFrom: spaceshipStatuses
		                     afterA: movement
		                     from: player
		                     on: self
]

{ #category : 'private' }
MessirveSpaceRaceGame >> nameOfSpaceShipPlaying [

	^ (spaceshipStatuses at: currentTurn) spaceShip
]

{ #category : 'private' }
MessirveSpaceRaceGame >> nextTurn [

	currentTurn := spaceShipSequence next.
	self isFinished ifFalse: [ 
		gameStatus := MessirveSpaceGameStartOfTurnStatus new ]
]

{ #category : 'private' }
MessirveSpaceRaceGame >> obtainSpaceShipStatusFrom: aSpaceShip [

	|aStatus|
	
	aStatus := spaceshipStatuses detect: [ :status | 
		  status spaceShip == aSpaceShip ].
	
	^aStatus
]

{ #category : 'playing' }
MessirveSpaceRaceGame >> playGame [

	self playNextTurn.
	self isFinished ifFalse: [ self playGame ]
]

{ #category : 'playing' }
MessirveSpaceRaceGame >> playNextTurn [

	self assertGameIsNotFinished.
	self currentSpaceShipStatus conductTheTurnOn: self.
]

{ #category : 'accessing' }
MessirveSpaceRaceGame >> positionOfSpaceship: aSpaceShip [

	^ (self obtainSpaceShipStatusFrom: aSpaceShip) tile
]

{ #category : 'accessing' }
MessirveSpaceRaceGame >> ranking [

	^ ranking
]

{ #category : 'removing' }
MessirveSpaceRaceGame >> setPenalizationOf: positions to: player [
	
	spaceshipStatuses := board
		                     newStatusesFrom: spaceshipStatuses
		                     afterA: positions
		                     fromPenalized: player
		                     on: self.
]

{ #category : 'accessing' }
MessirveSpaceRaceGame >> spaceShip: cardPlayer plays: aCard on: cardTarget [
	
	cardApplicator
		spaceShip: cardPlayer
		plays: aCard
		on: cardTarget
		from: self
]

{ #category : 'playing' }
MessirveSpaceRaceGame >> spaceShip: cardPlayer plays: aReversalCard onTile: aTile fromBoard: aBoard [ 
	
	cardApplicator
		spaceShip: cardPlayer
		plays: aReversalCard
		onTile: aTile
		fromBoard: aBoard
]

{ #category : 'accessing' }
MessirveSpaceRaceGame >> spaceShip: cardPlayer playsCancellationCardOn: cardTarget on: aBoard [
	
	cardApplicator applyCancellationTargetting: cardTarget on: aBoard.
]

{ #category : 'accessing' }
MessirveSpaceRaceGame >> winner [

	^ gameStatus winner
]

{ #category : 'private' }
MessirveSpaceRaceGame >> winnerExists [

	^ spaceshipStatuses anySatisfy: [ :status | status lap = lapsToWin ]
]
