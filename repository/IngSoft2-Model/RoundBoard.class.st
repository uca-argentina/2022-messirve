Class {
	#name : #RoundBoard,
	#superclass : #Object,
	#instVars : [
		'startingPosition',
		'boardEffects',
		'lastPosition',
		'parsecs',
		'lastEffectApplied'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #verification }
RoundBoard class >> assertValidBoardPositions: boardPositions [

	boardPositions size < 2 ifTrue: [ 
		Error signal: 'A board cannot have less than two positions' ]
]

{ #category : #verification }
RoundBoard class >> assertValidNumberOfPositions: numberOfPositions [

	numberOfPositions < 2 ifTrue: [ 
		Error signal: 'A board cannot have less than two positions' ]
]

{ #category : #verification }
RoundBoard class >> assertValidParsecs: someParsecs [

	someParsecs < 1 ifTrue: [ 
		Error signal: 'A board cannot be initialized with 0 or less parsecs' ]
]

{ #category : #initialization }
RoundBoard class >> boardWithOnly: effectPositions at: effectTileNumbers Of: numberOfPositions and: aNumberOfParsecs [

	| boardPositions |
	self assertValidParsecs: aNumberOfParsecs.
	self assertValidNumberOfPositions: numberOfPositions.

	boardPositions := self noEffectPositionBoardWith: numberOfPositions.
	1 to: effectTileNumbers size do: [ :i | 
		boardPositions
			at: (effectTileNumbers at: i)
			put: (effectPositions at: i) ].

	^ self new
		  initializeWithPositions: boardPositions
		  and: aNumberOfParsecs
]

{ #category : #'instance creation' }
RoundBoard class >> noEffectPositionBoardWith: numberOfTiles [

	| boardPositions |
	boardPositions := OrderedCollection new.
	1 to: numberOfTiles do: [ :i | boardPositions add: NonEffect new ].
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
RoundBoard >> advance: aStatus from: statuses to: aPosition [

	| newStatus newStatuses |
	newStatus := SpaceShipStatus with: aStatus spaceShip and: aPosition.

	newStatuses := statuses copy.
	newStatuses replaceAll: aStatus with: newStatus.
	^ newStatuses
]

{ #category : #'as yet unclassified' }
RoundBoard >> applyLastEffectTo: aSpaceShipStatus from: statuses on: aGame [

	| effectApplicator |
	effectApplicator := EffectApplicator new.

	^ effectApplicator
		  apply: lastEffectApplied
		  on: statuses
		  activatedBy: aSpaceShipStatus
		  playedOn: self
		  and: aGame
]

{ #category : #accessing }
RoundBoard >> effectAppliedOnPosition: aPosition [

	^ boardEffects at: aPosition
]

{ #category : #initialization }
RoundBoard >> initializeWithPositions: boardPositions and: anAmountOfParsecs [

	startingPosition := 1.
	boardEffects := boardPositions asOrderedCollection.
	lastPosition := boardPositions size.
	parsecs := anAmountOfParsecs.
]

{ #category : #private }
RoundBoard >> lapAfter: aStatus rolled: diceResult on: aGame [

	| newLaps currentLaps lapsToAdd positionOfSpaceship  newPosition |
	currentLaps := aStatus position lap.
	positionOfSpaceship := aStatus position tile.

	newPosition := aStatus position tile + diceResult.

	lapsToAdd := newPosition = lastPosition
		             ifTrue: [ 0 ]
		             ifFalse: [ 
			             newPosition = 0
				             ifTrue: [ -1 ]
				             ifFalse: [ newPosition // lastPosition ] ].

	newLaps := currentLaps + lapsToAdd.

	newLaps > aGame lapsToWin
		ifTrue: [ ^ aGame lapsToWin ]
		ifFalse: [ 
			newLaps < 1
				ifTrue: [ ^ 1 ]
				ifFalse: [ ^ newLaps ] ]
]

{ #category : #accessing }
RoundBoard >> lastPosition [

	^ lastPosition
]

{ #category : #private }
RoundBoard >> newPositionAfter: aStatus rolled: aDiceResult on: aGame [

	| aTile aLap |
	aTile := self tileAfter: aStatus rolled: aDiceResult.
	aLap := self lapAfter: aStatus rolled: aDiceResult on: aGame.

	^ SpaceShipPosition with: aTile and: aLap on: self
]

{ #category : #private }
RoundBoard >> newStatusesAfter: newStatus applyingTheEffectOf: newPosition over: newStatuses on: aGame [

	| effectApplicator |
	lastEffectApplied := self effectAppliedOnPosition: newPosition tile.
	effectApplicator := EffectApplicator new.
	^ effectApplicator
		  apply: lastEffectApplied
		  on: newStatuses
		  activatedBy: newStatus
		  playedOn: self
		  and: aGame
]

{ #category : #private }
RoundBoard >> newStatusesFrom: statuses afterA: diceRoll from: rollingStatus on: aGame [

	| newPosition newStatus newStatuses |
	newPosition := self
		               newPositionAfter: rollingStatus
		               rolled: diceRoll
		               on: aGame.
	newStatus := SpaceShipStatus
		             with: rollingStatus spaceShip
		             and: newPosition.
	newStatuses := statuses copy.
	newStatuses replaceAll: rollingStatus with: newStatus.
	^ self
		  newStatusesAfter: newStatus
		  applyingTheEffectOf: newPosition
		  over: newStatuses
		  on: aGame
]

{ #category : #accessing }
RoundBoard >> parsecsPerPosition [

	^ parsecs / lastPosition
]

{ #category : #accessing }
RoundBoard >> startingPosition [

	^ startingPosition
]

{ #category : #private }
RoundBoard >> tileAfter: aSpaceShipStatus rolled: diceRoll [

	| newPosition |
	newPosition := aSpaceShipStatus position tile + diceRoll.

	newPosition > lastPosition ifTrue: [ ^ newPosition % lastPosition ].

	newPosition <= 0 ifTrue: [ 
		aSpaceShipStatus lap = 1
			ifTrue: [ ^ 1 ]
			ifFalse: [ 
				newPosition = 0
					ifTrue: [ ^ lastPosition ]
					ifFalse: [ ^ newPosition % lastPosition ] ] ].

	^ newPosition
]
