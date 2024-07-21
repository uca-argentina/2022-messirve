"
Moves the player who lands on the position forward instead of backward.
"
Class {
	#name : 'WormHoleReversedEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
WormHoleReversedEffect >> applyEffectOf: positions on: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ effectApplicator
		  applyBoostOf: positions * -1
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame 
]

{ #category : 'highlighting' }
WormHoleReversedEffect >> reverse [
 	^WormHoleNormalEffect new.
]
