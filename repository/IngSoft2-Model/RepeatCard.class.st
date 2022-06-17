Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
RepeatCard >> activatedTo: aTarget poweredBy: anEnginePowerApplicator on: aCardApplicator from: aGame [ 

	anEnginePowerApplicator applyRepeatTargetting: aTarget in: aCardApplicator from: aGame
]

{ #category : #asserting }
RepeatCard >> handleLastPlayedWithPlayOf: cardPlayer at: cardTarget on: aCardApplicator from: aGame [

	aCardApplicator assertSpaceShip: cardPlayer owns: self.
	aCardApplicator makeLastPlayed: self
]

{ #category : #private }
RepeatCard >> inventoriesAfterTargeting: aTarget from: inventories on: aCardApplicator [

	^ inventories
]
