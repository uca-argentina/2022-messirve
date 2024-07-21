"
Moves a player forward a standard number of positions on the game board.







"
Class {
	#name : 'SpeedUpNormalEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
SpeedUpNormalEffect >> applyEffectOf: positions on: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ effectApplicator
		  applyBoostOf: positions
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame
]

{ #category : 'highlighting' }
SpeedUpNormalEffect >> reverse [
	^SpeedUpReversedEffect new
]
