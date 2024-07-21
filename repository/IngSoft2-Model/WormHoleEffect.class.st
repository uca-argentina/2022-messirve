"
Moves the player who lands on the position back a few spaces.
"
Class {
	#name : 'WormHoleEffect',
	#superclass : 'Object',
	#instVars : [
		'effectOrientation'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'private' }
WormHoleEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ effectOrientation
		  applyEffectOf: -4
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame
		  appliedBy: effectApplicator
]

{ #category : 'private' }
WormHoleEffect >> reverseEffect [

	effectOrientation := effectOrientation reverse.
]
