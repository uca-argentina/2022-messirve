"
Allows a player to repeat the use of the last card played.
"
Class {
	#name : 'RedoCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'private' }
RedoCard >> activatedTo: aCard poweredBy: anEnginePowerApplicator on: aCardApplicator from: aGame [

	anEnginePowerApplicator
		applyEnginePowerTo: aCard
		afterPlaying: aCardApplicator lastCardPlayed
		on: aCardApplicator
		from: aGame
]

{ #category : 'asserting' }
RedoCard >> handleLastPlayedWithPlayOf: cardPlayer at: cardTarget on: aCardApplicator from: aGame [

	aCardApplicator assertSpaceShip: cardPlayer owns: self.
	aCardApplicator lastCardPlayed assertCanBePlayedOnTurnOf: cardPlayer from: aGame
]

{ #category : 'private' }
RedoCard >> inventoriesAfterTargeting: target from: inventories on: aBoard [

	^ aBoard lastCardPlayed
		  inventoriesAfterTargeting: target
		  from: inventories
		  on: aBoard
]
