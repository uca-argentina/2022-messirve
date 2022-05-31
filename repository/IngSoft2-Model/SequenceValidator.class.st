Class {
	#name : #SequenceValidator,
	#superclass : #Object,
	#instVars : [
		'currentSequenceNumber',
		'objectSequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SequenceValidator class >> formedBy: aSequence [

	^ self new initializeFormedBy: aSequence
]

{ #category : #processing }
SequenceValidator >> advanceSequenceNumber [

	self calculateNextInSequence.
	^ currentSequenceNumber
]

{ #category : #private }
SequenceValidator >> calculateNextInSequence [

	currentSequenceNumber := currentSequenceNumber == objectSequence size
		                         ifTrue: [ 1 ]
		                         ifFalse: [ currentSequenceNumber + 1 ]
]

{ #category : #initialize }
SequenceValidator >> initializeFormedBy: aSequence [

	objectSequence := aSequence.
	currentSequenceNumber := 1
]
