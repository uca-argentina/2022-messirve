"
Moves players backward in a standard manner, simulating a typical moonwalk effect.
"
Class {
	#name : 'MoonWalkNormalEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
MoonWalkNormalEffect >> applyEffectOf: positions on: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ effectApplicator
		  applyMoonWalkOf: positions * -1
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame 
]

{ #category : 'private' }
MoonWalkNormalEffect >> reverse [
	^MoonWalkReversedEffect new.
]
