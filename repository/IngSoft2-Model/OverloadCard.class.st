Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
OverloadCard >> activatedBy: aSpaceShip on: anEnginePowerApplicator [

	anEnginePowerApplicator powerEngineOf: aSpaceShip by: -1
]

{ #category : #asserting }
OverloadCard >> assertValidCardPlayOf: cardPlayer on: aBoard from: aGame [

	aGame assertPermanentPlayedOnCorrectlyBy: cardPlayer.
	aBoard assertSpaceShip: cardPlayer owns: self
]

{ #category : #'as yet unclassified' }
OverloadCard >> inventoriesAfterTargeting: cardTarget from: inventories on: aBoard [

	^ aBoard inventoriesAfter: cardTarget wasApplied: self
]
