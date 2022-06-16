Class {
	#name : #RedoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
RedoCard >> activatedTo: aCard poweredBy: anEnginePowerApplicator on: aCardApplicator from: aGame [

	anEnginePowerApplicator
		applyEnginePowerTo: aCard
		afterPlaying: aCardApplicator lastCardPlayed
		on: aCardApplicator
		from: aGame
]

{ #category : #asserting }
RedoCard >> handleLastPlayedWithPlayOf: cardPlayer at: cardTarget on: aCardApplicator from: aGame [

	aCardApplicator assertSpaceShip: cardPlayer owns: self
]

{ #category : #'as yet unclassified' }
RedoCard >> inventoriesAfterTargeting: target from: inventories on: aBoard [

	^ aBoard lastCardPlayed
		  inventoriesAfterTargeting: target
		  from: inventories
		  on: aBoard
]
