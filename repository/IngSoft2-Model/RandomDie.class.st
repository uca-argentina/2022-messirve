"
A die that generates random numbers, used to introduce chance into the game.
"
Class {
	#name : 'RandomDie',
	#superclass : 'Object',
	#instVars : [
		'sides'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'verification' }
RandomDie class >> assertValidSides: sides [

	sides < 3 ifTrue: [ 
		Error signal: 'A die cannot have less than three sides' ]
]

{ #category : 'initialize' }
RandomDie class >> withSides: sides [

	self assertValidSides: sides.
	^ self new initializeWithSides: sides
]

{ #category : 'initialization' }
RandomDie >> initializeWithSides: numberOfSides [

	sides := numberOfSides
]

{ #category : 'action' }
RandomDie >> roll [

	^ sides atRandom
]
