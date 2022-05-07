Class {
	#name : #StraightBoard,
	#superclass : #Object,
	#instVars : [
		'positions',
		'startingPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
StraightBoard class >> assertValidPositions: numberOfPositions [
	numberOfPositions < 2
		ifTrue: [ Error signal: 'A straight board cannot have less than two positions' ]
]

{ #category : #initialization }
StraightBoard class >> withPositions: numberOfPositions [
	self assertValidPositions: numberOfPositions.
	^self new initializeWithPositions: numberOfPositions
]

{ #category : #private }
StraightBoard >> finalPositionWhenStartingAt: spaceshipPosition afterRolling: diceRoll [

	| newPosition |
	newPosition := spaceshipPosition + diceRoll.

	^ newPosition min: positions
]

{ #category : #initialization }
StraightBoard >> initializeWithPositions: numberOfPositions [
	startingPosition := 1.
	positions := numberOfPositions 
]

{ #category : #accessing }
StraightBoard >> positions [
	^ positions
]

{ #category : #accessing }
StraightBoard >> startingPosition [
	^startingPosition
]
