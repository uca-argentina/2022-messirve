"
Handles the distribution of cards to players at the start or during the game.
"
Class {
	#name : 'CardDealer',
	#superclass : 'Object',
	#instVars : [
		'deck',
		'cardHandingSequence'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
CardDealer class >> handing: cards [

	^ self new initializeHanding: cards
]

{ #category : 'private' }
CardDealer >> hand: aCard to: aSpaceShipInventory [

	^ aSpaceShipInventory draw: aCard
]

{ #category : 'action handling' }
CardDealer >> handCardFromDeckTo: aSpaceShipInventory [

	| cardToHand |
	cardToHand := deck at: cardHandingSequence currentSequenceNumber.
	cardHandingSequence next.
	^ aSpaceShipInventory draw: cardToHand
]

{ #category : 'initialization' }
CardDealer >> initializeHanding: cards [

	deck := cards.
	cardHandingSequence := Sequence formedBy: cards
]

{ #category : 'action handling' }
CardDealer >> inventoriesAfterDrawingTwoFrom: inventories [

	| inventoriesAfterDrawingOne |
	inventoriesAfterDrawingOne := inventories collect: [ :inventory | 
		                              self handCardFromDeckTo: inventory ].
	^ inventoriesAfterDrawingOne collect: [ :inventory | 
		  self handCardFromDeckTo: inventory ]
]

{ #category : 'removing' }
CardDealer >> removeRandomCardFrom: aSpaceShipInventory [

	^ aSpaceShipInventory discardRandomCard.
]
