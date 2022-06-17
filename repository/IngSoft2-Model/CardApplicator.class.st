Class {
	#name : #CardApplicator,
	#superclass : #Object,
	#instVars : [
		'cardDealer',
		'inventories',
		'globalInventory',
		'engineApplicator',
		'lastCardPlayed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardApplicator class >> handing: someCards to: somePlayers [

	^ self new initializeHanding: someCards to: somePlayers
]

{ #category : #'as yet unclassified' }
CardApplicator >> activeCardsOf: aSpaceShip [

	^ (inventories detect: [ :inventory | 
		   inventory spaceShip = aSpaceShip ]) activeCards
]

{ #category : #'as yet unclassified' }
CardApplicator >> applyAllNegatedCardsOf: aCard [

	inventories do: [ :inventory | self applyNegatedAndRemove: aCard from: inventory ].

	globalInventory do: [ :card | 
		card = aCard ifTrue: [ 
			aCard applyNegatedOn: card on: engineApplicator from: self ] ]
]

{ #category : #'as yet unclassified' }
CardApplicator >> applyNegatedAndRemove: aCard from: inventory [

	^ inventory activeCards do: [ :card | 
		  card = aCard ifTrue: [ 
			  aCard
				  applyNegatedOn: inventory spaceShip
				  on: engineApplicator
				  from: self ] ]
]

{ #category : #'as yet unclassified' }
CardApplicator >> applyRepeatTargetting: aSpaceShip from: aGame [

	aGame applyLastEffectTo: aSpaceShip
]

{ #category : #asserting }
CardApplicator >> assertCardIsActive: aCard [ 

	| activeCardsExist globalCardExists |
	activeCardsExist := inventories anySatisfy: [ :inventory | 
		                    inventory activeCards anySatisfy: [ :activeCard | activeCard == aCard ] ].

	globalCardExists := globalInventory isNotEmpty.
	(globalCardExists or: activeCardsExist) ifFalse: [ 
		Error signal: 'The targeted card is not currently active' ]
]

{ #category : #asserting }
CardApplicator >> assertSpaceShip: aSpaceShip owns: aCard [

	| spaceShipInventory cardExists |
	spaceShipInventory := inventories detect: [ :inventory | 
		                      inventory spaceShip = aSpaceShip ].
	cardExists := spaceShipInventory inventory anySatisfy: [ :card | 
		              card == aCard ].
	cardExists ifFalse: [ Error signal: 'SpaceShip doesnt own that card' ]
]

{ #category : #asserting }
CardApplicator >> assertThereAreActiveCardsInPlay [

	| activeCardsExist globalActiveCardsExist |
	globalActiveCardsExist := globalInventory isNotEmpty.
	activeCardsExist := inventories anySatisfy: [ :inventory | 
		                    inventory activeCards isNotEmpty ].

	(activeCardsExist or: globalActiveCardsExist) ifFalse: [ 
		Error signal: 'No cards available to cancel' ]
]

{ #category : #accessing }
CardApplicator >> cardsInInventoryOf: aSpaceShip [

	^ (inventories detect: [ :inventory | 
		   inventory spaceShip = aSpaceShip ]) inventory
]

{ #category : #'as yet unclassified' }
CardApplicator >> distribute: aCard toTheInventoryOf: aSpaceShip [

	| inventory newInventory |
	inventory := inventories detect: [ :inven | 
		             inven spaceShip = aSpaceShip ].
	newInventory := cardDealer hand: aCard to: inventory.
	inventories replaceAll: inventory with: newInventory
]

{ #category : #'as yet unclassified' }
CardApplicator >> distributeInitialCardsTo: spaceShipNames [

	inventories := spaceShipNames collect: [ :spaceShip | 
		               SpaceShipInventory carriedBy: spaceShip ].

	inventories := cardDealer inventoriesAfterDrawingTwoFrom: inventories
]

{ #category : #'as yet unclassified' }
CardApplicator >> enginePowerOf: aSpaceShip [ 

	^engineApplicator powerOf: aSpaceShip 
]

{ #category : #initialization }
CardApplicator >> initializeHanding: someCards to: spaceShips [

	cardDealer := CardDealer handing: someCards.
	self distributeInitialCardsTo: spaceShips.
	globalInventory := OrderedCollection new.
	engineApplicator := EnginePowerApplicator with: spaceShips.
	

]

{ #category : #'as yet unclassified' }
CardApplicator >> inventoriesAfter: cardTarget wasApplied: aCard [

	| inventoryOfCardTarget |
	inventoryOfCardTarget := inventories detect: [ :inventory | 
		                         inventory spaceShip == cardTarget ].
	inventoryOfCardTarget addCardToActiveCards: aCard.
	^ inventories
]

{ #category : #'as yet unclassified' }
CardApplicator >> inventoriesAfterNewGlobalCardOf: anAccelerationCard [

	globalInventory add: anAccelerationCard.
	^ inventories
]

{ #category : #'as yet unclassified' }
CardApplicator >> inventoriesAfterRemoving: aCard from: someInventories [

	| newInventories |
	newInventories := someInventories do: [ :inventory | 
		                  inventory activeCards removeAllSuchThat: [ :card | 
			                  card = aCard ] ].
	^ newInventories
]

{ #category : #accessing }
CardApplicator >> lastCardPlayed [

	^ lastCardPlayed
]

{ #category : #'as yet unclassified' }
CardApplicator >> makeLastPlayed: aCard [

	lastCardPlayed := aCard
]

{ #category : #'as yet unclassified' }
CardApplicator >> remove: aCard from: cardPlayer [

	| inventoryOfCardPlayer |
	inventoryOfCardPlayer := inventories detect: [ :inventory | 
		                         inventory spaceShip == cardPlayer ].
	inventoryOfCardPlayer removeFromInventory: aCard
]

{ #category : #'as yet unclassified' }
CardApplicator >> spaceShip: cardPlayer plays: aCard on: cardTarget from: aGame [

	aCard handleLastPlayedWithPlayOf: cardPlayer at: cardTarget on: self from: aGame.

	self remove: aCard from: cardPlayer.

	engineApplicator applyEnginePowerTo: cardTarget afterPlaying: aCard	on: self from: aGame.
	inventories := aCard inventoriesAfterTargeting: cardTarget from: inventories on: self
]
