"
Moves a player backward instead of forward, reversing the typical speed-up effect.
"
Class {
	#name : 'SpeedUpReversedEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
SpeedUpReversedEffect >> applyEffectOf: positions on: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ effectApplicator
		  applyBoostOf: positions * -1
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame
]

{ #category : 'highlighting' }
SpeedUpReversedEffect >> reverse [
	^SpeedUpNormalEffect new.
]
