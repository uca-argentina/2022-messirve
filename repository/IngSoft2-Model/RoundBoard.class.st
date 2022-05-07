Class {
	#name : #RoundBoard,
	#superclass : #Object,
	#instVars : [
		'startingPosition',
		'positions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
RoundBoard class >> assertValidPositions: numberOfPositions [ 
		numberOfPositions < 2
		ifTrue: [ Error signal: 'A round board cannot have less than two positions' ]
]

{ #category : #initialization }
RoundBoard class >> withPositions: numberOfPositions [
	self assertValidPositions: numberOfPositions.
	^self new initializeWithPositions: numberOfPositions
]

{ #category : #accessing }
RoundBoard >> finalPositionWhenStartingAt: spaceshipPosition afterRolling: diceRoll [

	| newPosition |
	newPosition := spaceshipPosition + diceRoll.
	newPosition > positions
		ifTrue: [ ^newPosition % positions  ]
		ifFalse: [ ^newPosition ]
]

{ #category : #initialization }
RoundBoard >> initializeWithPositions: numberOfPositions [ 
	startingPosition := 1.
	positions := numberOfPositions 
]

{ #category : #accessing }
RoundBoard >> positions [
	^ positions
]

{ #category : #accessing }
RoundBoard >> startingPosition [
	^ startingPosition
]
