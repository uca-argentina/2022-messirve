"
Moves players forward instead of backward, reversing the typical moonwalk effect.
"
Class {
	#name : 'MoonWalkReversedEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
MoonWalkReversedEffect >> applyEffectOf: positions on: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ effectApplicator
		  applyMoonWalkOf: positions
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame 
]

{ #category : 'private' }
MoonWalkReversedEffect >> reverse [
	^MoonWalkNormalEffect new.
]
