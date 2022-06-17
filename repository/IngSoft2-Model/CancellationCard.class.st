Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CancellationCard >> activatedTo: aCard poweredBy: anEnginePowerApplicator on: aCardApplicator from: aMessirveSpaceRaceGame [

	anEnginePowerApplicator
		applyCancellationTargetting: aCard
		in: aCardApplicator
]

{ #category : #asserting }
CancellationCard >> assertCanBePlayedOnTurnOf: cardPlayer from: aMessirveSpaceRaceGame [ 
	
	^ self
]

{ #category : #asserting }
CancellationCard >> handleLastPlayedWithPlayOf: cardPlayer at: cardTarget on: aCardApplicator from: aGame [

	aCardApplicator assertSpaceShip: cardPlayer owns: self.
	aCardApplicator assertThereAreActiveCardsInPlay.
	aCardApplicator assertCardIsActive: cardTarget.
	aCardApplicator makeLastPlayed: self
]

{ #category : #'as yet unclassified' }
CancellationCard >> inventoriesAfterTargeting: cardTarget from: inventories on: aCardApplicator [

	^ aCardApplicator
		  inventoriesAfterRemoving: cardTarget
		  from: inventories
]
