Class {
	#name : #Sequence,
	#superclass : #Object,
	#instVars : [
		'currentSequenceNumber',
		'objectSequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Sequence class >> formedBy: aSequence [

	^ self new initializeFormedBy: aSequence
]

{ #category : #private }
Sequence >> calculateNextInSequence [

	currentSequenceNumber := currentSequenceNumber == objectSequence size
		                         ifTrue: [ 1 ]
		                         ifFalse: [ currentSequenceNumber + 1 ]
]

{ #category : #accessing }
Sequence >> currentSequenceNumber [

	^ currentSequenceNumber
]

{ #category : #initialize }
Sequence >> initializeFormedBy: aSequence [

	objectSequence := aSequence.
	currentSequenceNumber := 1
]

{ #category : #processing }
Sequence >> next [

	self calculateNextInSequence.
	^ currentSequenceNumber
]
