"
A die that is biased to produce certain numbers more frequently than others.
"
Class {
	#name : 'LoadedDie',
	#superclass : 'Object',
	#instVars : [
		'rollSequence',
		'results'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'initialization' }
LoadedDie class >> rolling: aRoll [ 
	^self new initializeWithRoll: aRoll.
]

{ #category : 'initialization' }
LoadedDie >> initializeWithRoll: someRolls [ 
	
	rollSequence := Sequence formedBy: someRolls.
	results := someRolls.
	
]

{ #category : 'action' }
LoadedDie >> roll [
	| currentRoll |
	currentRoll := (results at: rollSequence currentSequenceNumber) copy.
	rollSequence next.
	^currentRoll.
]
