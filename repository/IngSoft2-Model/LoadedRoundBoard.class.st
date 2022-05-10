Class {
	#name : #LoadedRoundBoard,
	#superclass : #Object,
	#instVars : [
		'startingPosition',
		'boardEffects',
		'lastPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
LoadedRoundBoard class >> assertValidPositions: boardPositions [ 
		boardPositions size < 2
		ifTrue: [ Error signal: 'A round board cannot have less than two positions' ]
]

{ #category : #initialization }
LoadedRoundBoard class >> withPositions: boardPositions [
	self assertValidPositions: boardPositions.
	^self new initializeWithPositions: boardPositions
]

{ #category : #accessing }
LoadedRoundBoard >> effectAppliedOnPosition: aPosition [
	^boardEffects at: aPosition.
]

{ #category : #accessing }
LoadedRoundBoard >> finalPositionWhenStartingAt: spaceshipPosition afterRolling: diceRoll [

	| newPosition |
	newPosition := spaceshipPosition + diceRoll.
	newPosition > lastPosition ifTrue: [ ^ newPosition % lastPosition ].

	newPosition < 0 ifTrue: [ ^ newPosition % lastPosition ].

	^ newPosition
]

{ #category : #initialization }
LoadedRoundBoard >> initializeWithPositions: boardPositions [ 
	startingPosition := 1.
	boardEffects := boardPositions asOrderedCollection .
	lastPosition := boardPositions size. 
]

{ #category : #accessing }
LoadedRoundBoard >> lastPosition [
	^ lastPosition
]

{ #category : #accessing }
LoadedRoundBoard >> startingPosition [
	^ startingPosition
]
