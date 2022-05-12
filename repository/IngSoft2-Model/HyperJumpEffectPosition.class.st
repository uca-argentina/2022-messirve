Class {
	#name : #HyperJumpEffectPosition,
	#superclass : #Object,
	#instVars : [
		'parsecs',
		'parsecIndex'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJumpEffectPosition class >> with: parsecs [ 
	^self new initializeWith: parsecs.
]

{ #category : #'as yet unclassified' }
HyperJumpEffectPosition >> advanceIndex [
	parsecIndex := parsecIndex == parsecs size
		                         ifTrue: [ 1 ]
		                         ifFalse: [ parsecIndex + 1 ]
]

{ #category : #applying }
HyperJumpEffectPosition >> applyEffectOn: aGame [ 
	| positionLength boost|
	positionLength := aGame parsecsPerPosition.
	boost := (parsecs at: parsecIndex) // positionLength.
	self advanceIndex.
	aGame applyBoostOf: boost .
	
]

{ #category : #initialization }
HyperJumpEffectPosition >> initializeWith: someParsecs [ 
	parsecs := someParsecs.
	parsecIndex := 1.
]
