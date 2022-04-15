Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'positions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
Board class >> assertValidPositions: numberOfPositions [
	numberOfPositions < 2
		ifTrue: [ Error signal: 'A board cannot have less than two positions' ]
]

{ #category : #initialization }
Board class >> withPositions: numberOfPositions [
	self assertValidPositions: numberOfPositions.
	^self new initializeWith: numberOfPositions
]

{ #category : #initialization }
Board >> initializeWith: numberOfPositions [
	positions := numberOfPositions 
]

{ #category : #processing }
Board >> obtainPositionStartingIn: spaceshipPosition afterRolling: diceRoll [

	| newPosition |
	newPosition := spaceshipPosition + diceRoll.
	newPosition <= positions
		ifTrue: [ ^ newPosition ]
		ifFalse: [ ^ positions ]
]

{ #category : #accessing }
Board >> positions [
	^ positions
]
