Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'roll',
		'currentIndex',
		'rollSequence'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
LoadedDie class >> rolling: aRoll [ 
	^self new initializeWithRoll: aRoll.
]

{ #category : #private }
LoadedDie >> increaseIndex [
	currentIndex := rollSequence advanceSequenceNumber.
]

{ #category : #initialization }
LoadedDie >> initializeWithRoll: aRoll [ 
	
	rollSequence := SequenceValidator formedBy: aRoll.
	roll := aRoll.
	currentIndex := 1.
	
]

{ #category : #action }
LoadedDie >> roll [
	| currentRoll |
	currentRoll := roll at: currentIndex.
	self increaseIndex.
	^currentRoll.
]
