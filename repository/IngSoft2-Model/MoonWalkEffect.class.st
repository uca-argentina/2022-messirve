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

{ #category : #'as yet unclassified' }
MoonWalkEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^effectApplicator
		applyMoonWalkOf: -1 * backwardPositions
		on: statuses
		activatedBy: aStatus
		playedOn: aBoard
		and: aGame
]

{ #category : #initialization }
MoonWalkEffect >> initializeWithBackPositionsOf: backPositions [
	backwardPositions := backPositions.
]
