Class {
	#name : #SpaceShipStatus,
	#superclass : #Object,
	#instVars : [
		'spaceShip',
		'distance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpaceShipStatus class >> with: aSpaceShip and: aSpaceShipDistance [

	^ self new initializeWith: aSpaceShip and: aSpaceShipDistance
]

{ #category : #accessing }
SpaceShipStatus >> distance [

	^ distance
]

{ #category : #initialization }
SpaceShipStatus >> initializeWith: aSpaceShip and: aSpaceShipDistance [

	spaceShip := aSpaceShip.
	distance := aSpaceShipDistance
]

{ #category : #accessing }
SpaceShipStatus >> lap [

	^ distance lap
]

{ #category : #accessing }
SpaceShipStatus >> position [

	^ distance position
]

{ #category : #accessing }
SpaceShipStatus >> spaceShip [

	^ spaceShip
]
