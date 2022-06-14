Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CancellationCard >> activatedBy: aSpaceShip on: anEnginePowerApplicator [

	anEnginePowerApplicator slowDownAllEngines
]

{ #category : #'as yet unclassified' }
CancellationCard >> activatedBy: aSpaceShip on: anEnginePowerApplicator from: aRoundBoard [

	anEnginePowerApplicator slowDownAllEngines
]

{ #category : #asserting }
CancellationCard >> assertValidCardPlayOf: cardPlayer at: cardTarget on: aBoard from: aGame [

	aBoard assertSpaceShip: cardPlayer owns: self.
	aBoard assertThereAreActiveCardsInPlay.
	aBoard assertCardIsActive: cardTarget
]

{ #category : #'as yet unclassified' }
CancellationCard >> inventoriesAfterTargeting: cardTarget from: inventories on: aBoard [

	^ inventories
]
