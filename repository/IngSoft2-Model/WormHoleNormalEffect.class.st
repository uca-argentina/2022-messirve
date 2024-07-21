"
Moves the player who lands on the position back a standard number of spaces.
"
Class {
	#name : 'WormHoleNormalEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
WormHoleNormalEffect >> applyEffectOf: positions on: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ effectApplicator
		  applyBoostOf: positions
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame
]

{ #category : 'highlighting' }
WormHoleNormalEffect >> reverse [
 	^WormHoleReversedEffect new.
]
