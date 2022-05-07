Class {
	#name : #SpaceShipStatus,
	#superclass : #Object,
	#instVars : [
		'spaceShip',
		'position',
		'lap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
SpaceShipStatus class >> with: aSpaceShip placedAt: aPosition on: aLap [ 
	^self new initializeWith: aSpaceShip placedAt: aPosition on: aLap.
]

{ #category : #accessing }
SpaceShipStatus >> initializeWith: aSpaceShipName placedAt: aPosition on: aLap [
	spaceShip := aSpaceShipName .
	position := aPosition.
	lap := aLap.
]

{ #category : #'as yet unclassified' }
SpaceShipStatus >> lap [
	^lap
]

{ #category : #accessing }
SpaceShipStatus >> position [
	^ position
]

{ #category : #accessing }
SpaceShipStatus >> spaceShip [
	^ spaceShip
]
