Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'roll',
		'currentIndex'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
LoadedDie class >> rolling: aRoll [ 
	^self new initializeWithRoll: aRoll.
]

{ #category : #private }
LoadedDie >> increaseIndex [
	currentIndex := currentIndex == roll size
		                         ifTrue: [ 1 ]
		                         ifFalse: [ currentIndex + 1 ]
]

{ #category : #initialization }
LoadedDie >> initializeWithRoll: aRoll [ 
	currentIndex := 1.
	roll := aRoll.
]

{ #category : #action }
LoadedDie >> roll [
	| currentRoll |
	currentRoll := roll at: currentIndex.
	self increaseIndex.
	^currentRoll.
]
