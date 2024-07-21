"
Triggers a hyper jump, moving game entities instantly across the game board.
"
Class {
	#name : 'HyperJumpEffect',
	#superclass : 'Object',
	#instVars : [
		'sequence',
		'distanceUnits',
		'effectOrientation'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'asserting' }
HyperJumpEffect class >> assertValid: someParsecs and: someLightyears [

	someParsecs size = someLightyears size ifFalse: [ 
		Error signal:
			'Parsec and lightyear collection must have the same size' ]
]

{ #category : 'initialization' }
HyperJumpEffect class >> with: someParsecs and: someLightyears [

	| distanceUnits |
	self assertValid: someParsecs and: someLightyears.
	distanceUnits := OrderedCollection new.
	1 to: someParsecs size do: [ :i | 
		distanceUnits add: (SpaceGameDistanceUnit
				 with: (someParsecs at: i)
				 and: (someLightyears at: i)) ].
	^ self new initializeWith: distanceUnits
]

{ #category : 'private' }
HyperJumpEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	| aDistance |
	aDistance := distanceUnits at: sequence currentSequenceNumber.
	sequence next.
		
	^ effectOrientation
		  applyEffectOf: aDistance 
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame
		  appliedBy: effectApplicator
]

{ #category : 'initialization' }
HyperJumpEffect >> initializeWith: someDistanceUnits [

	distanceUnits := someDistanceUnits.
	sequence := Sequence formedBy: distanceUnits.
	effectOrientation := HyperJumpNormalEffect new. 
]

{ #category : 'private' }
HyperJumpEffect >> reverseEffect [
	effectOrientation := effectOrientation reverse.
]
