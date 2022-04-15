Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
DiceCup class >> initializeWithDice: aCollectionOfDice [
	^self new initializeWithDice: aCollectionOfDice.
]

{ #category : #accessing }
DiceCup >> dice [
	^ dice
]

{ #category : #initialization }
DiceCup >> initializeWithDice: aCollectionOfDice [
	dice := aCollectionOfDice .
]

{ #category : #action }
DiceCup >> roll [
	^dice sum: [ : die | die roll].
]
