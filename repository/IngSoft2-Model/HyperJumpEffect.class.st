Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'parsecs',
		'parsecIndex',
		'parsecSequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJumpEffect class >> with: parsecs [

	^ self new initializeWith: parsecs
]

{ #category : #private }
HyperJumpEffect >> advanceIndex [

	parsecIndex := parsecSequence advanceSequenceNumber
]

{ #category : #private }
HyperJumpEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	| positionLength boost |
	positionLength := aGame parsecsPerPosition.
	boost := (parsecs at: parsecIndex) // positionLength.
	self advanceIndex.

	^ effectApplicator
		  applyBoostOf: boost
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame
]

{ #category : #initialization }
HyperJumpEffect >> initializeWith: someParsecs [

	parsecSequence := SequenceValidator formedBy: someParsecs.
	parsecs := someParsecs.
	parsecIndex := 1
]
