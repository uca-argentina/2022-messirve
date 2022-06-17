Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'sequence',
		'sequenceStart',
		'distanceUnits'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
HyperJumpEffect class >> assertValid: someParsecs and: someLightyears [

	someParsecs size = someLightyears size ifFalse: [ 
		Error signal:
			'Parsec and lightyear collection must have the same size' ]
]

{ #category : #initialization }
HyperJumpEffect class >> with: someParsecs and: someLightyears [

	| distanceUnits |
	distanceUnits := OrderedCollection new.
	self assertValid: someParsecs and: someLightyears.
	1 to: someParsecs size do: [ :i | 
		distanceUnits add: (SpaceGameDistanceUnit
				 with: (someParsecs at: i)
				 and: (someLightyears at: i)) ].
	^ self new initializeWith: distanceUnits
]

{ #category : #private }
HyperJumpEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	| aDistance |
	aDistance := distanceUnits at: sequence currentSequenceNumber.
	sequence next.

	^ effectApplicator
		  applyHyperJumpEffectWith: aDistance
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame
]

{ #category : #initialization }
HyperJumpEffect >> initializeWith: someDistanceUnits [

	distanceUnits := someDistanceUnits.
	sequence := Sequence formedBy: distanceUnits.
	sequenceStart := 1
]

{ #category : #private }
HyperJumpEffect >> next [

	sequenceStart := sequence next
]
