"
Applies the effects or actions of a card to the game or specific players.
"
Class {
	#name : 'CardApplicator',
	#superclass : 'Object',
	#instVars : [
		'cardDealer',
		'inventories',
		'globalInventory',
		'engineApplicator',
		'lastCardPlayed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
CardApplicator class >> handing: someCards to: somePlayers [

	^ self new initializeHanding: someCards to: somePlayers
]

{ #category : 'accessing' }
CardApplicator >> activeCardsOf: aSpaceShip [

	^ (inventories detect: [ :inventory | 
		   inventory spaceShip = aSpaceShip ]) activeCards
]

{ #category : 'applying' }
CardApplicator >> applyAllNegatedCardsOf: aCard [

	inventories do: [ :inventory | self applyNegatedAndRemove: aCard from: inventory ].

	globalInventory do: [ :card | 
		card = aCard ifTrue: [ 
			aCard applyNegatedOn: card on: engineApplicator from: self ] ]
]

{ #category : 'applying' }
CardApplicator >> applyCancellationTargetting: aReversalCard on: aBoard [
	
	aReversalCard applyNegatedEffectOn: aBoard.
]

{ #category : 'applying' }
CardApplicator >> applyNegatedAndRemove: aCard from: inventory [

	^ inventory activeCards do: [ :card | 
		  card = aCard ifTrue: [ 
			  aCard
				  applyNegatedOn: inventory spaceShip
				  on: engineApplicator
				  from: self ] ]
]

{ #category : 'applying' }
CardApplicator >> applyRepeatTargetting: aSpaceShip from: aGame [

	aGame applyLastEffectTo: aSpaceShip
]

{ #category : 'asserting' }
CardApplicator >> assertCardIsActive: aCard [ 

	| activeCardsExist globalCardExists |
	activeCardsExist := inventories anySatisfy: [ :inventory | 
		                    inventory activeCards anySatisfy: [ :activeCard | activeCard == aCard ] ].

	globalCardExists := globalInventory isNotEmpty.
	(globalCardExists or: activeCardsExist) ifFalse: [ 
		Error signal: 'The targeted card is not currently active' ]
]

{ #category : 'asserting' }
CardApplicator >> assertSpaceShip: aSpaceShip owns: aCard [

	| spaceShipInventory cardExists |
	spaceShipInventory := inventories detect: [ :inventory | 
		                      inventory spaceShip = aSpaceShip ].
	cardExists := spaceShipInventory inventory anySatisfy: [ :card | 
		              card == aCard ].
	cardExists ifFalse: [ Error signal: 'SpaceShip doesnt own that card' ]
]

{ #category : 'asserting' }
CardApplicator >> assertThereAreActiveCardsInPlay [

	| activeCardsExist globalActiveCardsExist |
	globalActiveCardsExist := globalInventory isNotEmpty.
	activeCardsExist := inventories anySatisfy: [ :inventory | 
		                    inventory activeCards isNotEmpty ].

	(activeCardsExist or: globalActiveCardsExist) ifFalse: [ 
		Error signal: 'No cards available to cancel' ]
]

{ #category : 'accessing' }
CardApplicator >> cardsInInventoryOf: aSpaceShip [

	^ (inventories detect: [ :inventory | 
		   inventory spaceShip = aSpaceShip ]) inventory
]

{ #category : 'private' }
CardApplicator >> distribute: aCard toTheInventoryOf: aSpaceShip [

	| inventory newInventory |
	inventory := inventories detect: [ :inven | 
		             inven spaceShip = aSpaceShip ].
	newInventory := cardDealer hand: aCard to: inventory.
	inventories replaceAll: inventory with: newInventory
]

{ #category : 'private' }
CardApplicator >> distributeInitialCardsTo: spaceShipNames [

	inventories := spaceShipNames collect: [ :spaceShip | 
		               SpaceShipInventory carriedBy: spaceShip ].

	inventories := cardDealer inventoriesAfterDrawingTwoFrom: inventories
]

{ #category : 'accessing' }
CardApplicator >> enginePowerOf: aSpaceShip [ 

	^engineApplicator powerOf: aSpaceShip 
]

{ #category : 'initialization' }
CardApplicator >> initializeHanding: someCards to: spaceShips [

	cardDealer := CardDealer handing: someCards.
	self distributeInitialCardsTo: spaceShips.
	globalInventory := OrderedCollection new.
	engineApplicator := EnginePowerApplicator with: spaceShips.
	

]

{ #category : 'private' }
CardApplicator >> inventoriesAfter: cardPlayer played: aCard [
	
	| inventoryOfCardPlayer |
	inventoryOfCardPlayer := inventories detect: [ :inventory | 
		                         inventory spaceShip == cardPlayer ].
	inventoryOfCardPlayer addCardToActiveCards: aCard.
	^ inventories
	
	
	
]

{ #category : 'accessing' }
CardApplicator >> inventoriesAfter: cardTarget wasApplied: aCard [

	| inventoryOfCardTarget |
	inventoryOfCardTarget := inventories detect: [ :inventory | 
		                         inventory spaceShip == cardTarget ].
	inventoryOfCardTarget addCardToActiveCards: aCard.
	^ inventories
]

{ #category : 'accessing' }
CardApplicator >> inventoriesAfterNewGlobalCardOf: aCard [

	globalInventory add: aCard.
	^ inventories
]

{ #category : 'private' }
CardApplicator >> inventoriesAfterRemoving: aCard from: someInventories [

	| newInventories |
	newInventories := someInventories do: [ :inventory | 
		                  inventory activeCards removeAllSuchThat: [ :card | 
			                  card = aCard ] ].
	^ newInventories
]

{ #category : 'accessing' }
CardApplicator >> lastCardPlayed [

	^ lastCardPlayed
]

{ #category : 'private' }
CardApplicator >> makeLastPlayed: aCard [

	lastCardPlayed := aCard
]

{ #category : 'private' }
CardApplicator >> remove: aCard from: cardPlayer [

	| inventoryOfCardPlayer |
	inventoryOfCardPlayer := inventories detect: [ :inventory | 
		                         inventory spaceShip == cardPlayer ].
	inventoryOfCardPlayer removeFromInventory: aCard
]

{ #category : 'removing' }
CardApplicator >> removeRandomCardFromTheInventoryOf: aSpaceShip [ 

	| inventory newInventory |
	inventory := inventories detect: [ :inven | 
		             inven spaceShip = aSpaceShip ].
	newInventory := cardDealer removeRandomCardFrom: inventory.
	inventories replaceAll: inventory with: newInventory
]

{ #category : 'private' }
CardApplicator >> spaceShip: cardPlayer plays: aCard on: cardTarget from: aGame [

	aCard handleLastPlayedWithPlayOf: cardPlayer at: cardTarget on: self from: aGame.

	self remove: aCard from: cardPlayer.

	engineApplicator applyEnginePowerTo: cardTarget afterPlaying: aCard	on: self from: aGame.
	inventories := aCard inventoriesAfterTargeting: cardTarget from: inventories on: self
]

{ #category : 'private' }
CardApplicator >> spaceShip: cardPlayer plays: aCard onTile: aTile fromBoard: aBoard [ 
	
	aCard applyReversalEffectOn: aTile from: aBoard.
	
	self remove: aCard from: cardPlayer.
	
	inventories := self inventoriesAfter: cardPlayer played: aCard
]
