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
		'engineApplicator',
		'lastCardPlayed',
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
RoundBoard >> assertCardIsActive: aCard [ 

	| activeCardsExist |
	activeCardsExist := inventories anySatisfy: [ :inventory | 
		                    inventory activeCards anySatisfy: [ :activeCard | activeCard == aCard ] ].

	activeCardsExist ifFalse: [ 
		Error signal: 'The targeted card is not currently active' ]
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

{ #category : #asserting }
RoundBoard >> assertThereAreActiveCardsInPlay [

	| activeCardsExist |
	activeCardsExist := inventories anySatisfy: [ :inventory | 
		                    inventory activeCards isNotEmpty ].

	activeCardsExist ifFalse: [ 
		Error signal: 'No cards available to cancel' ]
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

{ #category : #'as yet unclassified' }
RoundBoard >> inventoriesAfter: cardTarget wasApplied: aCard [

	| inventoryOfCardTarget |
	inventoryOfCardTarget := inventories detect: [ :inventory | 
		                         inventory spaceShip == cardTarget ].
	inventoryOfCardTarget addCardToActiveCards: aCard.
	^ inventories
]

{ #category : #private }
RoundBoard >> lapAfter: aStatus rolled: diceResult on: aGame [

	| newLaps currentLaps lapsToAdd positionOfSpaceship movement newPosition |
	currentLaps := aStatus position lap.
	positionOfSpaceship := aStatus position tile.

	movement := diceResult
	            + (engineApplicator powerOf: aStatus spaceShip).
	newPosition := aStatus position tile + movement.

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
RoundBoard >> lastCardPlayed [

	^ lastCardPlayed
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

{ #category : #'as yet unclassified' }
RoundBoard >> spaceShip: cardPlayer plays: aCard on: cardTarget from: aGame [

	| inventoryOfCardPlayer cardRemoved |
	self assertSpaceShip: cardPlayer owns: aCard.
	aCard
		assertValidCardPlayOf: cardPlayer
		at: cardTarget
		on: self
		from: aGame.

	inventoryOfCardPlayer := inventories detect: [ :inventory | 
		                         inventory spaceShip == cardPlayer ].
	cardRemoved := inventoryOfCardPlayer removeFromInventory: aCard.

	inventories := aCard
		               inventoriesAfterTargeting: cardTarget
		               from: inventories
		               on: self.

	engineApplicator applyEnginePowerTo: cardTarget afterPlaying: aCard on: self.
	lastCardPlayed := cardRemoved
]

{ #category : #'as yet unclassified' }
RoundBoard >> startEnginesOf: spaceShipNames [

	engineApplicator := EnginePowerApplicator with: spaceShipNames
]

{ #category : #accessing }
RoundBoard >> startingPosition [

	^ startingPosition
]

{ #category : #private }
RoundBoard >> tileAfter: aSpaceShipStatus rolled: diceRoll [

	| newPosition movement |
	movement := diceRoll
	            + (engineApplicator powerOf: aSpaceShipStatus spaceShip).
	newPosition := aSpaceShipStatus position tile + movement.

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
