Class {
	#name : #SpaceShip,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpaceShip class >> withName: aName [ 
	^self new initializeWith: aName.
]

{ #category : #initialization }
SpaceShip >> initializeWith: aName [
	name := aName.
]

{ #category : #accessing }
SpaceShip >> name [
	^ name
]
