Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #verification }
DiceCup class >> assertValidQuantityOf: dice [

	dice ifEmpty: [ Error signal: 'A dice cup cannot be empty' ]
]

{ #category : #initialization }
DiceCup class >> withAll: dice [

	self assertValidQuantityOf: dice.
	^ self new initializeWithAll: dice
]

{ #category : #initialization }
DiceCup >> initializeWithAll: someDice [

	dice := someDice
]

{ #category : #action }
DiceCup >> roll [

	^ dice sum: [ :die | die roll ]
]
