Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
DiceCup class >> withAll: dice [
	^self new withAll: dice.
]

{ #category : #action }
DiceCup >> roll [
	^dice sum: [ : die | die roll].
]

{ #category : #initialization }
DiceCup >> withAll: aCollectionOfDice [
	dice := aCollectionOfDice .
]
