Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'sequence',
		'distance',
		'sequenceStart'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJumpEffect class >> with: parsecs [

	^ self new initializeWith: parsecs
]

{ #category : #private }
HyperJumpEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	| aDistance |
	aDistance := (distance at: sequenceStart).
	self next.

	^ effectApplicator
		  applyHyperJumpEffectWith: aDistance
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame
]

{ #category : #initialization }
HyperJumpEffect >> initializeWith: someParsecs [

	sequence := Sequence formedBy: someParsecs.
	distance := someParsecs.
	sequenceStart := 1
]

{ #category : #private }
HyperJumpEffect >> next [

	sequenceStart := sequence next
]
