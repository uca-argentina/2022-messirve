"
A permanent card that increases the speed of game entities, enhancing their movement abilities.
"
Class {
	#name : 'SpeedCard',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'private' }
SpeedCard >> activatedTo: aSpaceShip poweredBy: anEnginePowerApplicator on: aCardApplicator from: aMessirveSpaceRaceGame [ 

	anEnginePowerApplicator powerEngineOf: aSpaceShip by: 1
]

{ #category : 'private' }
SpeedCard >> applyNegatedOn: aSpaceShip on: anEnginePowerApplicator from: aRoundBoard [ 

	anEnginePowerApplicator powerEngineOf: aSpaceShip by: -1
]

{ #category : 'private' }
SpeedCard >> inventoriesAfterTargeting: cardTarget from: inventories on: aCardApplicator [

	^ aCardApplicator inventoriesAfter: cardTarget wasApplied: self
]
