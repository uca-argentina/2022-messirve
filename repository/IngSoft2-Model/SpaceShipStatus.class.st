Class {
	#name : #SpaceShipStatus,
	#superclass : #Object,
	#instVars : [
		'spaceShip',
		'position',
		'inventory'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpaceShipStatus class >> with: aSpaceShip and: aSpaceShipDistance [

	^ self new initializeWith: aSpaceShip and: aSpaceShipDistance
]

{ #category : #initialization }
SpaceShipStatus >> initializeWith: aSpaceShip and: aSpaceShipPosition [

	spaceShip := aSpaceShip.
	position := aSpaceShipPosition.
	inventory := OrderedCollection new.
]

{ #category : #accessing }
SpaceShipStatus >> inventory [

	^ inventory
]

{ #category : #accessing }
SpaceShipStatus >> lap [

	^ position lap
]

{ #category : #'action handling' }
SpaceShipStatus >> pick: aCard [

	inventory add: aCard.
	^ self
]

{ #category : #accessing }
SpaceShipStatus >> position [
	^ position
]

{ #category : #accessing }
SpaceShipStatus >> spaceShip [

	^ spaceShip
]

{ #category : #accessing }
SpaceShipStatus >> tile [

	^ position tile
]
