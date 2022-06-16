Class {
	#name : #OverloadCard,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
OverloadCard >> activatedTo: aSpaceShip poweredBy: anEnginePowerApplicator on: aCardApplicator from: aMessirveSpaceRaceGame [

	anEnginePowerApplicator powerEngineOf: aSpaceShip by: -1
]

{ #category : #'as yet unclassified' }
OverloadCard >> applyNegatedOn: aSpaceShip on: anEnginePowerApplicator from: aRoundBoard [

	anEnginePowerApplicator powerEngineOf: aSpaceShip by: 1
]

{ #category : #'as yet unclassified' }
OverloadCard >> inventoriesAfterTargeting: cardTarget from: inventories on: aCardApplicator [

	^ aCardApplicator inventoriesAfter: cardTarget wasApplied: self
]
