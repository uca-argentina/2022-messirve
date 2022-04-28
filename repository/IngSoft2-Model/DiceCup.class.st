Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
DiceCup class >> initializeWithDice: dice [
	^self new initializeWithDice: dice.
]

{ #category : #initialization }
DiceCup >> initializeWithDice: aCollectionOfDice [
	dice := aCollectionOfDice .
]

{ #category : #action }
DiceCup >> roll [
	^dice sum: [ : die | die roll].
]
