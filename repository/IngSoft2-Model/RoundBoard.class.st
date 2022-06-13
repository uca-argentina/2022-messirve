Class {
	#name : #RoundBoard,
	#superclass : #Object,
	#instVars : [
		'startingPosition',
		'boardEffects',
		'lastPosition',
		'parsecs',
		'cardDealer',
		'inventories',
		'engineApplicator'
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
			at: (effectTileNumbers at: i)
			put: (effectPositions at: i) ].
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

{ #category : #asserting }
RoundBoard >> assertSpaceShip: spaceShip owns: aCard [

	| spaceShipInventory cardExists |
	spaceShipInventory := inventories detect: [ :inventory | 
		                      inventory spaceShip = spaceShip ].
	cardExists := spaceShipInventory inventory anySatisfy: [ :card | 
		              card == aCard ].
	cardExists ifFalse: [ Error signal: 'SpaceShip doesnt own that card' ]
]

{ #category : #initialization }
RoundBoard >> assignInventoriesFrom: spaceShipNames [

	inventories := spaceShipNames collect: [ :spaceShip | 
		               SpaceShipInventory carriedBy: spaceShip ]
]

{ #category : #accessing }
RoundBoard >> cardsInInventoryOf: aSpaceShipName [

	^ inventories detect: [ :inventory | 
		  inventory spaceShip = aSpaceShipName ]
]

{ #category : #'as yet unclassified' }
RoundBoard >> distribute: aCard toTheInventoryOf: aSpaceShip [

	| inventory newInventory |
	inventory := inventories detect: [ :inven | 
		             inven spaceShip = aSpaceShip ].
	newInventory := cardDealer hand: aCard to: inventory.
	inventories replaceAll: inventory with: newInventory
]

{ #category : #private }
RoundBoard >> distributeInitialCardsFrom: spaceShipNames [

	self assignInventoriesFrom: spaceShipNames.
	inventories := cardDealer inventoriesAfterDrawingTwoFrom: inventories.
]

{ #category : #accessing }
RoundBoard >> effectAppliedOnPosition: aPosition [

	^ boardEffects at: aPosition
]

{ #category : #'as yet unclassified' }
RoundBoard >> initialSetUpWith: spaceShipNames [ 
	
	self distributeInitialCardsFrom: spaceShipNames.
	self startEnginesOf: spaceShipNames.
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
	newPosition := aSpaceShipStatus position tile + diceRoll
	               +
	               (engineApplicator powerOf: aSpaceShipStatus spaceShip).
	newPosition > lastPosition ifTrue: [ ^ newPosition % lastPosition ].

	newPosition < 0 ifTrue: [ 
		aSpaceShipStatus lap = 1
			ifFalse: [ ^ newPosition % lastPosition ]
			ifTrue: [ ^ 1 ] ].

	^ newPosition
]

{ #category : #'as yet unclassified' }
RoundBoard >> spaceShip: cardPlayer plays: aCard on: cardTarget [

	| inventoryOfCardPlayer inventoryOfCardTarget cardRemoved |
	self assertSpaceShip: cardPlayer owns: aCard.

	inventoryOfCardPlayer := inventories detect: [ :inventory | 
		                         inventory spaceShip == cardPlayer ].
	cardRemoved := inventoryOfCardPlayer removeFromInventory: aCard.

	inventoryOfCardTarget := inventories detect: [ :inventory | 
		                         inventory spaceShip == cardTarget ].
	inventoryOfCardTarget addCardToActiveCards: cardRemoved
]

{ #category : #'as yet unclassified' }
RoundBoard >> startEnginesOf: spaceShipNames [

	engineApplicator := EnginePowerApplicator with: spaceShipNames
]

{ #category : #accessing }
RoundBoard >> startingPosition [

	^ startingPosition
]
