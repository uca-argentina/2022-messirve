Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AccelerationCard >> activatedBy: spaceShips on: anEnginePowerApplicator [

	anEnginePowerApplicator accelerateAllEngines
]

{ #category : #asserting }
AccelerationCard >> assertValidCardPlayOf: cardPlayer on: aBoard from: aGame [

	aGame assertPermanentPlayedOnCorrectlyBy: cardPlayer.
	aBoard assertSpaceShip: cardPlayer owns: self
]

{ #category : #'as yet unclassified' }
AccelerationCard >> inventoriesAfterTargeting: cardTarget from: inventories on: aBoard [

	^ inventories
]
