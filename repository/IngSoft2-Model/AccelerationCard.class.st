Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AccelerationCard >> activatedTo: aSpaceShip on: anEnginePowerApplicator from: aRoundBoard [

	anEnginePowerApplicator accelerateAllEngines
]

{ #category : #'as yet unclassified' }
AccelerationCard >> applyNegatedOn: anAccelerationCard on: anEnginePowerApplicator from: aRoundBoard [

	anEnginePowerApplicator slowDownAllEngines
]

{ #category : #asserting }
AccelerationCard >> assertValidCardPlayOf: cardPlayer at: cardTarget on: aCardApplicator from: aGame [

	aGame assertPermanentPlayedOnCorrectlyBy: cardPlayer.
	aCardApplicator assertSpaceShip: cardPlayer owns: self
]

{ #category : #'as yet unclassified' }
AccelerationCard >> inventoriesAfterTargeting: target from: inventories on: cardApplicator [

	^ cardApplicator inventoriesAfterNewGlobalCardOf: self
]
