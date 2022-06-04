Class {
	#name : #RoundBoard,
	#superclass : #Object,
	#instVars : [
		'startingPosition',
		'boardEffects',
		'lastPosition',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #verification }
RoundBoard class >> assertValidBoardPositions: boardPositions [ 
		boardPositions size < 2
		ifTrue: [ Error signal: 'A board cannot have less than two positions' ]
]

{ #category : #verification }
RoundBoard class >> assertValidNumberOfPositions: numberOfPositions [
		numberOfPositions < 2
		ifTrue: [ Error signal: 'A board cannot have less than two positions' ]
]

{ #category : #verification }
RoundBoard class >> assertValidParsecs: someParsecs [ 
		someParsecs < 1
		ifTrue: [ Error signal: 'A board cannot be initialized with 0 or less parsecs' ]
]

{ #category : #initialization }
RoundBoard class >> boardWithOnly: effectPositions at: effectTileNumbers Of: numberOfPositions and: aNumberOfParsecs [

	| boardPositions |
	self assertValidParsecs: aNumberOfParsecs.
	self assertValidNumberOfPositions: numberOfPositions.

	boardPositions := self noEffectPositionBoardWith: numberOfPositions.
	1 to: effectTileNumbers size do: [ :i | 
		boardPositions
			at: (effectTileNumbers at: 1)
			put: (effectPositions at: 1) ].
	^ self new initializeWithPositions: boardPositions and: aNumberOfParsecs
]

{ #category : #'instance creation' }
RoundBoard class >> noEffectPositionBoardWith: numberOfTiles [

	| boardPositions |
	boardPositions := OrderedCollection new.
	1 to: numberOfTiles do: [ :i | 
	boardPositions add: NonEffect new ].
	^ boardPositions
]

{ #category : #initialization }
RoundBoard class >> with: numberOfPositions and: aNumberOfParsecs [

	| defaultBoardPositions boardRandomizer |
	self assertValidParsecs: aNumberOfParsecs.
	self assertValidNumberOfPositions: numberOfPositions.

	boardRandomizer := BoardRandomizer new.

	defaultBoardPositions := boardRandomizer 
		                         assignDistributedBoardPositionsAdaptedTo:
		                         numberOfPositions.
	self assertValidBoardPositions: defaultBoardPositions.
	^ self new
		  initializeWithPositions: defaultBoardPositions
		  and: aNumberOfParsecs
]

{ #category : #initialization }
RoundBoard class >> withNoEffectsOf: numberOfPositions and: aNumberOfParsecs [

	| boardPositions |
	self assertValidParsecs: aNumberOfParsecs.
	self assertValidNumberOfPositions: numberOfPositions.

	boardPositions := self noEffectPositionBoardWith: numberOfPositions.
	^ self new
		  initializeWithPositions: boardPositions
		  and: aNumberOfParsecs
]

{ #category : #private }
RoundBoard >> advance: aStatus from: statuses to: aDistance [

	| newStatus newStatuses |
	newStatus := SpaceShipStatus with: aStatus spaceShip and: aDistance.

	newStatuses := statuses copy.
	newStatuses replaceAll: aStatus with: newStatus.
	^ newStatuses
]

{ #category : #private }
RoundBoard >> calculateLapAfter: aStatus rolled: diceResult on: aGame [

	| newLaps currentLaps lapsToAdd positionOfSpaceship |
	currentLaps := aStatus distance lap.
	positionOfSpaceship := aStatus distance position.
	lapsToAdd := positionOfSpaceship = self lastPosition
		             ifFalse: [ 
		             positionOfSpaceship + diceResult // self lastPosition ]
		             ifTrue: [ 0 ].

	newLaps := currentLaps + lapsToAdd.

	newLaps > aGame lapsToWin
		ifTrue: [ ^ aGame lapsToWin ]
		ifFalse: [ 
			newLaps < 1
				ifTrue: [ ^ 1 ]
				ifFalse: [ ^ newLaps ] ]
]

{ #category : #private }
RoundBoard >> calculateNew: statuses afterA: diceRoll from: rollingStatus on: aGame [

	| newDistance effectLanded effectApplicator newStatus newStatuses |
	newDistance := self
		               calculateNewDistanceAfter: rollingStatus
		               rolled: diceRoll
		               on: aGame.
		
	newStatus := SpaceShipStatus with: rollingStatus spaceShip and: newDistance.

	newStatuses := statuses copy.
	newStatuses replaceAll: rollingStatus with: newStatus.

	effectLanded := self effectAppliedOnPosition: newDistance position.
	effectApplicator := EffectApplicator new.
	^ effectApplicator
		  apply: effectLanded
		  on: newStatuses
		  activatedBy: newStatus
		  playedOn: self
		  and: aGame
]

{ #category : #private }
RoundBoard >> calculateNewDistanceAfter: aStatus rolled: aDiceResult on: aGame [

	| aPosition aLap |
	aPosition := self calculatePositionAfter: aStatus rolled: aDiceResult.
	aLap := self calculateLapAfter: aStatus rolled: aDiceResult on: aGame.

	^ SpaceShipDistance with: aPosition and: aLap on: self
]

{ #category : #private }
RoundBoard >> calculatePositionAfter: aSpaceShipStatus rolled: diceRoll [

	| newPosition |
	newPosition := aSpaceShipStatus distance position + diceRoll.
	newPosition > lastPosition ifTrue: [ ^ newPosition % lastPosition ].

	newPosition < 0 ifTrue: [ 
		aSpaceShipStatus lap = 1
			ifFalse: [ ^ newPosition % lastPosition ]
			ifTrue: [ ^ 1 ] ].

	^ newPosition
]

{ #category : #accessing }
RoundBoard >> effectAppliedOnPosition: aPosition [
	^boardEffects at: aPosition.
]

{ #category : #accessing }
RoundBoard >> finalPositionWhenStartingAt: spaceShipPosition afterRolling: diceRoll [

	| newPosition |
	newPosition := spaceShipPosition + diceRoll.
	newPosition > lastPosition ifTrue: [ ^ newPosition % lastPosition ].

	newPosition < 0 ifTrue: [ ^ 1 ].

	^ newPosition
]

{ #category : #initialization }
RoundBoard >> initializeWithPositions: boardPositions and: anAmountOfParsecs [
	
	startingPosition := 1 .
	boardEffects := boardPositions asOrderedCollection .
	lastPosition := boardPositions size.
	parsecs := anAmountOfParsecs. 
	
]

{ #category : #accessing }
RoundBoard >> lastPosition [
	^ lastPosition
]

{ #category : #accessing }
RoundBoard >> parsecsPerPosition [
	^parsecs / lastPosition.
]

{ #category : #accessing }
RoundBoard >> startingPosition [
	^ startingPosition
]
