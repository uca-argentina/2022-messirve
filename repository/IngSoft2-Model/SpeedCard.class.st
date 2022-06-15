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
SpeedCard >> assertValidCardPlayOf: cardPlayer at: cardTarget on: aBoard from: aGame [

	aGame assertPermanentPlayedOnCorrectlyBy: cardPlayer.
	aBoard assertSpaceShip: cardPlayer owns: self
]

{ #category : #'as yet unclassified' }
SpeedCard >> inventoriesAfterTargeting: cardTarget from: inventories on: aBoard [

	^ aBoard inventoriesAfter: cardTarget wasApplied: self
]
