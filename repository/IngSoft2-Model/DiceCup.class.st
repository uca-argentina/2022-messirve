Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
DiceCup class >> assertValidQuantityOf: dice [

	(dice isEmpty)
	ifTrue: [ Error signal: 'A dice cup cannot be empty' ].


]

{ #category : #initialization }
DiceCup class >> withAll: dice [
	self assertValidQuantityOf: dice. 
	^self new withAll: dice.
]

{ #category : #action }
DiceCup >> roll [
	^dice sum: [ : die | die roll].
]

{ #category : #initialization }
DiceCup >> withAll: someDice [
	dice := someDice .
]
