Class {
	#name : #SpaceShipInventory,
	#superclass : #Object,
	#instVars : [
		'spaceShip',
		'inventory',
		'activeCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpaceShipInventory class >> carriedBy: aSpaceShip [

	^ self new initializeCarriedBy: aSpaceShip
]

{ #category : #accessing }
SpaceShipInventory >> activeCards [

	^ activeCards
]

{ #category : #adding }
SpaceShipInventory >> addCardToActiveCards: aCard [

	activeCards add: aCard
]

{ #category : #drawing }
SpaceShipInventory >> draw: aCard [ 

	inventory add: aCard
]

{ #category : #initialization }
SpaceShipInventory >> initializeCarriedBy: aSpaceShip [

	spaceShip := aSpaceShip.
	inventory := OrderedCollection new.
	activeCards := OrderedCollection new
]

{ #category : #accessing }
SpaceShipInventory >> inventory [

	^ inventory
]

{ #category : #removing }
SpaceShipInventory >> removeFromInventory: aCard [

	inventory remove: aCard
]

{ #category : #accessing }
SpaceShipInventory >> spaceShip [
	^ spaceShip
]
