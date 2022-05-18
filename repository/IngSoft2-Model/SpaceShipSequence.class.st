Class {
	#name : #SpaceShipSequence,
	#superclass : #Object,
	#instVars : [
		'spaceShips',
		'currentSequenceNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpaceShipSequence class >> formedByAmountOfSpaceShips: spaceShips [

	^ self new initializeFormedByAmountOfSpaceShips: spaceShips
]

{ #category : #private }
SpaceShipSequence >> calculateNextSpaceShipInSequence [

	currentSequenceNumber := currentSequenceNumber == spaceShips size
		                         ifTrue: [ 1 ]
		                         ifFalse: [ currentSequenceNumber + 1 ]
]

{ #category : #initialize }
SpaceShipSequence >> initializeFormedByAmountOfSpaceShips: someSpaceShips [
	spaceShips := someSpaceShips.
	currentSequenceNumber := 1
]

{ #category : #processing }
SpaceShipSequence >> nextSequenceTurnNumber [

	self calculateNextSpaceShipInSequence.
	^ currentSequenceNumber
]
