Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CancellationCard >> activatedTo: aCard on: anEnginePowerApplicator from: aBoard [

	anEnginePowerApplicator applyCancellationTargetting: aCard in: aBoard
]

{ #category : #asserting }
CancellationCard >> assertValidCardPlayOf: cardPlayer at: cardTarget on: aBoard from: aGame [

	aBoard assertSpaceShip: cardPlayer owns: self.
	aBoard assertThereAreActiveCardsInPlay.
	aBoard assertCardIsActive: cardTarget
]

{ #category : #'as yet unclassified' }
CancellationCard >> inventoriesAfterTargeting: cardTarget from: inventories on: aBoard [

	^aBoard inventoriesAfterRemoving: cardTarget from: inventories
]
