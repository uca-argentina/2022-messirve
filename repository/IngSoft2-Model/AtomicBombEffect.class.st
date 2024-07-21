"
Represents the devastating effects and consequences of an atomic bomb explosion in the game.
"
Class {
	#name : 'AtomicBombEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'private' }
AtomicBombEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ effectApplicator applyAtomicBombOn: statuses playedOn: aBoard
]

{ #category : 'private' }
AtomicBombEffect >> reverseEffect [
	Error signal: 'Reversal cards can only be played on a valid effect position'
]
