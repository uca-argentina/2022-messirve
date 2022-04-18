Class {
	#name : #StraightBoard,
	#superclass : #Object,
	#instVars : [
		'positions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
StraightBoard class >> assertValidPositions: numberOfPositions [
	numberOfPositions < 2
		ifTrue: [ Error signal: 'A board cannot have less than two positions' ]
]

{ #category : #initialization }
StraightBoard class >> withPositions: numberOfPositions [
	self assertValidPositions: numberOfPositions.
	^self new initializeWith: numberOfPositions
]

{ #category : #initialization }
StraightBoard >> initializeWith: numberOfPositions [
	positions := numberOfPositions 
]

{ #category : #processing }
StraightBoard >> obtainPositionStartingIn: spaceshipPosition afterRolling: diceRoll [

	| newPosition |
	newPosition := spaceshipPosition + diceRoll.
	newPosition <= positions
		ifTrue: [ ^ newPosition ]
		ifFalse: [ ^ positions ]
]

{ #category : #accessing }
StraightBoard >> positions [
	^ positions
]