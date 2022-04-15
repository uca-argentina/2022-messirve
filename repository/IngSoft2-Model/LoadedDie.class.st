Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'roll'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
LoadedDie class >> rolling: aRoll [ 
	^self new initializeWithRoll: aRoll.
]

{ #category : #initialization }
LoadedDie >> initializeWithRoll: aRoll [ 
	roll := aRoll.
]

{ #category : #action }
LoadedDie >> roll [
	^ roll
]
