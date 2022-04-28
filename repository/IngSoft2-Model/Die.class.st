Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'sides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
Die class >> assertValidSides: sides [
	sides < 3
		ifTrue: [ Error signal: 'A die cannot have less than three sides' ]
]

{ #category : #initialize }
Die class >> withSides: sides [
	self assertValidSides: sides.
	^self new initializeWithSides: sides. 
]

{ #category : #initialization }
Die >> initializeWithSides: numberOfSides [
	sides := numberOfSides.
]

{ #category : #action }
Die >> roll [
	^sides atRandom .
]
