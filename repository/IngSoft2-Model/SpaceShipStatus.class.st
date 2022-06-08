Class {
	#name : #SpaceShipStatus,
	#superclass : #Object,
	#instVars : [
		'spaceShip',
		'position'
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
	position := aSpaceShipPosition
]

{ #category : #accessing }
SpaceShipStatus >> lap [

	^ position lap
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
