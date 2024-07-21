Class {
	#name : 'CancellationCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'private' }
CancellationCard >> activatedTo: aCard poweredBy: anEnginePowerApplicator on: aCardApplicator from: aMessirveSpaceRaceGame [

	anEnginePowerApplicator
		applyCancellationTargetting: aCard
		in: aCardApplicator
]

{ #category : 'private' }
CancellationCard >> assertCanBePlayedOnTurnOf: cardPlayer from: aMessirveSpaceRaceGame [ 
	
	^ self
]

{ #category : 'private' }
CancellationCard >> handleLastPlayedWithPlayOf: cardPlayer at: cardTarget on: aCardApplicator from: aGame [

	aCardApplicator assertSpaceShip: cardPlayer owns: self.
	aCardApplicator assertThereAreActiveCardsInPlay.
	aCardApplicator assertCardIsActive: cardTarget.
	aCardApplicator makeLastPlayed: self
]

{ #category : 'private' }
CancellationCard >> inventoriesAfterTargeting: cardTarget from: inventories on: aCardApplicator [

	^ aCardApplicator
		  inventoriesAfterRemoving: cardTarget
		  from: inventories
]
