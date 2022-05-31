Class {
	#name : #MoonWalkEffect,
	#superclass : #Object,
	#instVars : [
		'backwardPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
MoonWalkEffect class >> assertValidPositionsGoingBackOf: anAmountOfPositions [

		anAmountOfPositions < 1
		ifTrue: [ Error signal: 'Amount of back positions must be higher than 0' ]
]

{ #category : #initialization }
MoonWalkEffect class >> takingBack: anAmountOfPositions [

	self assertValidPositionsGoingBackOf: anAmountOfPositions.
	^ self new initializeWithBackPositionsOf: anAmountOfPositions
]

{ #category : #applying }
MoonWalkEffect >> applyEffectOn: aGame [

	aGame applyMoonWalkEffectWith: backwardPositions
]

{ #category : #initialization }
MoonWalkEffect >> initializeWithBackPositionsOf: backPositions [
	backwardPositions := backPositions.
]
