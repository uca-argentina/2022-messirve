Class {
	#name : #SpaceShipStatus,
	#superclass : #Object,
	#instVars : [
		'spaceShip',
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
SpaceShipStatus class >> with: aSpaceShip placedAt: aPosition [ 
	^self new initializeWith: aSpaceShip placedAt: aPosition.
]

{ #category : #accessing }
SpaceShipStatus >> initializeWith: aSpaceShip placedAt: aPosition [ 
	spaceShip := aSpaceShip .
	position := aPosition.
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
