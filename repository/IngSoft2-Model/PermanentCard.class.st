Class {
	#name : 'PermanentCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'asserting' }
PermanentCard >> assertCanBePlayedOnTurnOf: cardPlayer from: aGame [

	aGame assertPermanentPlayedOnCorrectlyBy: cardPlayer
]

{ #category : 'asserting' }
PermanentCard >> handleLastPlayedWithPlayOf: cardPlayer at: cardTarget on: aCardApplicator from: aGame [

	aCardApplicator assertSpaceShip: cardPlayer owns: self.
	aGame assertPermanentPlayedOnCorrectlyBy: cardPlayer.
	aCardApplicator makeLastPlayed: self
]
