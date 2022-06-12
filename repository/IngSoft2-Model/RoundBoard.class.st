Class {
	#name : #RoundBoard,
	#superclass : #Object,
	#instVars : [
		'startingPosition',
		'boardEffects',
		'lastPosition',
		'parsecs',
		'cardDealer',
		'inventories'
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
RoundBoard class >> boardWithOnly: effectPositions at: effectTileNumbers Of: numberOfPositions and: aNumberOfParsecs handing: cards [

	| boardPositions |
	self assertValidParsecs: aNumberOfParsecs.
	self assertValidNumberOfPositions: numberOfPositions.

	boardPositions := self noEffectPositionBoardWith: numberOfPositions.
	1 to: effectTileNumbers size do: [ :i | 
		boardPositions
			at: (effectTileNumbers at: 1)
			put: (effectPositions at: 1) ].
	^ self new
		  initializeWithPositions: boardPositions
		  and: aNumberOfParsecs
		  handing: cards
]

{ #category : #'instance creation' }
RoundBoard class >> noEffectPositionBoardWith: numberOfTiles [

	| boardPositions |
	boardPositions := OrderedCollection new.
	1 to: numberOfTiles do: [ :i | boardPositions add: NonEffect new ].
	^ boardPositions
]

{ #category : #initialization }
RoundBoard class >> with: numberOfPositions and: aNumberOfParsecs handing: cards [

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
		  handing: cards
]

{ #category : #initialization }
RoundBoard class >> withNoEffectsOf: numberOfPositions and: aNumberOfParsecs handing: cards [

	| boardPositions |
	self assertValidParsecs: aNumberOfParsecs.
	self assertValidNumberOfPositions: numberOfPositions.

	boardPositions := self noEffectPositionBoardWith: numberOfPositions.
	^ self new
		  initializeWithPositions: boardPositions
		  and: aNumberOfParsecs
		  handing: cards
]

{ #category : #private }
RoundBoard >> advance: aStatus from: statuses to: aPosition [

	| newStatus newStatuses |
	newStatus := SpaceShipStatus with: aStatus spaceShip and: aPosition.

	newStatuses := statuses copy.
	newStatuses replaceAll: aStatus with: newStatus.
	^ newStatuses
]

{ #category : #initialization }
RoundBoard >> assignInventoriesFrom: statuses [

	inventories := statuses collect: [ :status | 
		               SpaceShipInventory carriedBy: status spaceShip ]
]

{ #category : #accessing }
RoundBoard >> cardsInInventoryOf: aSpaceShipName [

	^ inventories detect: [ :inventory | 
		  inventory spaceShip == aSpaceShipName ]
]

{ #category : #private }
RoundBoard >> distributeInitialCardsFrom: statuses [

	self assignInventoriesFrom: statuses.
	inventories := cardDealer inventoriesAfterDrawingTwoFrom: inventories.
]

{ #category : #accessing }
RoundBoard >> effectAppliedOnPosition: aPosition [

	^ boardEffects at: aPosition
]

{ #category : #initialization }
RoundBoard >> initializeWithPositions: boardPositions and: anAmountOfParsecs handing: cards [

	startingPosition := 1.
	boardEffects := boardPositions asOrderedCollection.
	lastPosition := boardPositions size.
	parsecs := anAmountOfParsecs.
	cardDealer := CardDealer handing: cards.
	inventories := OrderedCollection new.
]

{ #category : #private }
RoundBoard >> lapAfter: aStatus rolled: diceResult on: aGame [

	| newLaps currentLaps lapsToAdd positionOfSpaceship |
	currentLaps := aStatus position lap.
	positionOfSpaceship := aStatus position tile.
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

{ #category : #accessing }
RoundBoard >> lastPosition [

	^ lastPosition
]

{ #category : #private }
RoundBoard >> newDistanceAfter: aStatus rolled: aDiceResult on: aGame [

	| aPosition aLap |
	aPosition := self positionAfter: aStatus rolled: aDiceResult.
	aLap := self lapAfter: aStatus rolled: aDiceResult on: aGame.

	^ SpaceShipPosition with: aPosition and: aLap on: self
]

{ #category : #private }
RoundBoard >> newStatusesAfter: newStatus applyingTheEffectOf: newPosition over: newStatuses on: aGame [

	| effectLanded effectApplicator |
	effectLanded := self effectAppliedOnPosition: newPosition tile.
	effectApplicator := EffectApplicator new.
	^ effectApplicator
		  apply: effectLanded
		  on: newStatuses
		  activatedBy: newStatus
		  playedOn: self
		  and: aGame
]

{ #category : #private }
RoundBoard >> newStatusesFrom: statuses afterA: diceRoll from: rollingStatus on: aGame [

	| newPosition newStatus newStatuses |
	newPosition := self
		               newDistanceAfter: rollingStatus
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

{ #category : #private }
RoundBoard >> positionAfter: aSpaceShipStatus rolled: diceRoll [

	| newPosition |
	newPosition := aSpaceShipStatus position tile + diceRoll.
	newPosition > lastPosition ifTrue: [ ^ newPosition % lastPosition ].

	newPosition < 0 ifTrue: [ 
		aSpaceShipStatus lap = 1
			ifFalse: [ ^ newPosition % lastPosition ]
			ifTrue: [ ^ 1 ] ].

	^ newPosition
]

{ #category : #accessing }
RoundBoard >> startingPosition [

	^ startingPosition
]
