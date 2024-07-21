Class {
	#name : 'OverloadCard',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'private' }
OverloadCard >> activatedTo: aSpaceShip poweredBy: anEnginePowerApplicator on: aCardApplicator from: aMessirveSpaceRaceGame [

	anEnginePowerApplicator powerEngineOf: aSpaceShip by: -2
]

{ #category : 'private' }
OverloadCard >> applyNegatedOn: aSpaceShip on: anEnginePowerApplicator from: aRoundBoard [

	anEnginePowerApplicator powerEngineOf: aSpaceShip by: 2
]

{ #category : 'private' }
OverloadCard >> inventoriesAfterTargeting: cardTarget from: inventories on: aCardApplicator [

	^ aCardApplicator inventoriesAfter: cardTarget wasApplied: self
]
