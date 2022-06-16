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
AccelerationCard >> handleLastPlayedWithPlayOf: cardPlayer at: cardTarget on: aCardApplicator from: aGame [

	aCardApplicator assertSpaceShip: cardPlayer owns: self.
	aGame assertPermanentPlayedOnCorrectlyBy: cardPlayer.
	aCardApplicator makeLastPlayed: self
]

{ #category : #'as yet unclassified' }
AccelerationCard >> inventoriesAfterTargeting: target from: inventories on: cardApplicator [

	^ cardApplicator inventoriesAfterNewGlobalCardOf: self
]
