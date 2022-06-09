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

{ #category : #initialization }
LoadedDie >> initializeWithRoll: aRoll [ 
	
	rollSequence := Sequence formedBy: aRoll.
	roll := aRoll.
	currentIndex := 1.
	
]

{ #category : #private }
LoadedDie >> next [
	currentIndex := rollSequence next.
]

{ #category : #action }
LoadedDie >> roll [
	| currentRoll |
	currentRoll := roll at: currentIndex.
	self next.
	^currentRoll.
]
