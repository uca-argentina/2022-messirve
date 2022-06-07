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

{ #category : #initialization }
SpaceShipDistance class >> with: aPosition and: aLap on: aBoard [

	^ self new initializeWith: aPosition and: aLap on: aBoard
]

{ #category : #initialization }
SpaceShipDistance >> initializeWith: aPosition and: aLap on: aBoard [

	position := aPosition.
	lap := aLap.
	distanceTraveled := lap * aBoard lastPosition + position
]

{ #category : #accessing }
SpaceShipDistance >> lap [
	^ lap
]

{ #category : #accessing }
SpaceShipDistance >> position [

	^ position
]

{ #category : #accessing }
SpaceShipDistance >> totalTraveled [
	^ distanceTraveled
]
