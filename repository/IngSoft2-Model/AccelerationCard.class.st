Class {
	#name : #AccelerationCard,
	#superclass : #PermanentCard,
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

{ #category : #'as yet unclassified' }
AccelerationCard >> inventoriesAfterTargeting: target from: inventories on: cardApplicator [

	^ cardApplicator inventoriesAfterNewGlobalCardOf: self
]
