Class {
	#name : #SpaceShipPosition,
	#superclass : #Object,
	#instVars : [
		'lap',
		'distanceTraveled',
		'tile'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpaceShipPosition class >> with: aPosition and: aLap on: aBoard [

	^ self new initializeWith: aPosition and: aLap on: aBoard
]

{ #category : #comparing }
SpaceShipPosition >> >= aSpaceShipPosition [ 
	^self totalTraveled >= aSpaceShipPosition totalTraveled
]

{ #category : #accessing }
SpaceShipPosition >> distanceTraveled [

	^ distanceTraveled
]

{ #category : #initialization }
SpaceShipPosition >> initializeWith: aPosition and: aLap on: aBoard [

	tile := aPosition.
	lap := aLap.
	distanceTraveled := (lap - 1) * aBoard lastPosition + tile
]

{ #category : #accessing }
SpaceShipPosition >> lap [
	^ lap
]

{ #category : #accessing }
SpaceShipPosition >> tile [

	^ tile
]

{ #category : #accessing }
SpaceShipPosition >> totalTraveled [
	^ distanceTraveled
]
