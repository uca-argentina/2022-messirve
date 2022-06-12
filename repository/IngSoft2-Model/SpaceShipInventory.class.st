Class {
	#name : #SpaceShipInventory,
	#superclass : #Object,
	#instVars : [
		'spaceShip',
		'inventory'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpaceShipInventory class >> carriedBy: aSpaceShip [

	^ self new initializeCarriedBy: aSpaceShip
]

{ #category : #drawing }
SpaceShipInventory >> draw: aCard [ 

	inventory add: aCard
]

{ #category : #initialization }
SpaceShipInventory >> initializeCarriedBy: aSpaceShip [

	spaceShip := aSpaceShip.
	inventory := OrderedCollection new.
]

{ #category : #accessing }
SpaceShipInventory >> inventory [

	^ inventory
]

{ #category : #accessing }
SpaceShipInventory >> spaceShip [
	^ spaceShip
]
