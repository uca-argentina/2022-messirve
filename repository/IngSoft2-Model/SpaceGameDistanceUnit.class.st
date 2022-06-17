Class {
	#name : #SpaceGameDistanceUnit,
	#superclass : #Object,
	#instVars : [
		'parsecs',
		'lightyears'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #verification }
SpaceGameDistanceUnit class >> assertGreaterThanZero: aNumber [

	aNumber < 0 ifTrue: [ 
		Error signal: 'Space game distance units cannot be lower than zero' ]
]

{ #category : #initialization }
SpaceGameDistanceUnit class >> with: parsecs and: lightyears [

	self assertGreaterThanZero: parsecs.
	self assertGreaterThanZero: lightyears.

	^ self new initializeWith: parsecs and: lightyears
]

{ #category : #initialization }
SpaceGameDistanceUnit >> initializeWith: someParsecs and: someLightyears [

	parsecs := someParsecs.
	lightyears := someLightyears
]

{ #category : #accessing }
SpaceGameDistanceUnit >> totalParsecs [

	^ parsecs + (lightyears / 3)
]
