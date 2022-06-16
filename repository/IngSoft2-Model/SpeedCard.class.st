Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedCard >> activatedTo: aSpaceShip on: anEnginePowerApplicator from: aRoundBoard [

	anEnginePowerApplicator powerEngineOf: aSpaceShip by: 1
]

{ #category : #'as yet unclassified' }
SpeedCard >> applyNegatedOn: aSpaceShip on: anEnginePowerApplicator from: aRoundBoard [ 

	anEnginePowerApplicator powerEngineOf: aSpaceShip by: -1
]

{ #category : #asserting }
SpeedCard >> handleLastPlayedWithPlayOf: cardPlayer at: cardTarget on: aCardApplicator from: aGame [

	aCardApplicator assertSpaceShip: cardPlayer owns: self.
	aGame assertPermanentPlayedOnCorrectlyBy: cardPlayer.
	aCardApplicator makeLastPlayed: self
]

{ #category : #'as yet unclassified' }
SpeedCard >> inventoriesAfterTargeting: cardTarget from: inventories on: aCardApplicator [

	^ aCardApplicator inventoriesAfter: cardTarget wasApplied: self
]
