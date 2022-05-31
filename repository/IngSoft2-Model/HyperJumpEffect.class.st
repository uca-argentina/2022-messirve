Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'parsecs',
		'parsecIndex',
		'parsecSequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJumpEffect class >> with: parsecs [ 
	^self new initializeWith: parsecs.
]

{ #category : #private }
HyperJumpEffect >> advanceIndex [

	parsecIndex := parsecSequence advanceSequenceNumber
]

{ #category : #applying }
HyperJumpEffect >> applyEffectOn: aGame [ 
	| positionLength boost|
	positionLength := aGame parsecsPerPosition.
	boost := (parsecs at: parsecIndex) // positionLength.
	self advanceIndex.
	aGame applyBoostOf: boost .
	
]

{ #category : #initialization }
HyperJumpEffect >> initializeWith: someParsecs [

	parsecSequence := SequenceValidator formedBy: someParsecs.
	parsecs := someParsecs.
	parsecIndex := 1
]
