Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
RepeatCard >> activatedTo: aString on: anEnginePowerApplicator from: aCardApplicator [ 
	self shouldBeImplemented.
]

{ #category : #asserting }
RepeatCard >> handleLastPlayedWithPlayOf: cardPlayer at: cardTarget on: aCardApplicator from: aGame [

	aCardApplicator assertSpaceShip: cardPlayer owns: self.
	aCardApplicator makeLastPlayed: self
]
