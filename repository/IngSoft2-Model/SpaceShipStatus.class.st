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
SpaceShipStatus class >> with: aSpaceShip [ 
	^self new initializeWith: aSpaceShip .
]

{ #category : #initialization }
SpaceShipStatus >> initializeWith: aSpaceShip [ 
	spaceShip := aSpaceShip .
	position := 1 .
]

{ #category : #accessing }
SpaceShipStatus >> position [
	^ position
]

{ #category : #accessing }
SpaceShipStatus >> spaceShip [
	^ spaceShip
]

{ #category : #playing }
SpaceShipStatus >> updateSpaceShipPositionWith: newPosition [ 
	position := newPosition  .
]
