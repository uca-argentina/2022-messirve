Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'parsecs',
		'parsecIndex'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJumpEffect class >> with: parsecs [ 
	^self new initializeWith: parsecs.
]

{ #category : #private }
HyperJumpEffect >> advanceIndex [
	parsecIndex := parsecIndex == parsecs size
		                         ifTrue: [ 1 ]
		                         ifFalse: [ parsecIndex + 1 ]
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
	parsecs := someParsecs.
	parsecIndex := 1.
]
