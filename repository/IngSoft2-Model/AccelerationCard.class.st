Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AccelerationCard >> activatedBy: spaceShips on: anEnginePowerApplicator [

	anEnginePowerApplicator accelerateAllEngines
]

{ #category : #'as yet unclassified' }
AccelerationCard >> inventoriesAfterTargeting: cardTarget from: inventories on: aBoard [

	^ inventories
]
