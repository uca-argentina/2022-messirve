Class {
	#name : #SpaceShipDistance,
	#superclass : #Object,
	#instVars : [
		'position',
		'lap',
		'distanceTraveled'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpaceShipDistance class >> with: aPosition and: aLap on: aBoard [ 
	^self new initializeWith: aPosition and: aLap on: aBoard. 
]

{ #category : #accessing }
SpaceShipDistance >> distanceTraveled [
	^ distanceTraveled
]

{ #category : #initialization }
SpaceShipDistance >> initializeWith: aPosition and: aLap on: aBoard [ 
	position := aPosition .
	lap := aLap .
	distanceTraveled := lap*(aBoard lastPosition) + position .
]

{ #category : #accessing }
SpaceShipDistance >> lap [
	^ lap
]

{ #category : #accessing }
SpaceShipDistance >> position [
	^ position
]
