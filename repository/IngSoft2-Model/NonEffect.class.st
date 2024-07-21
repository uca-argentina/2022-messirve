"
Indicates a no-effect condition, where no changes or actions occur in the game.
"
Class {
	#name : 'NonEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'private' }
NonEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ statuses copy.
]

{ #category : 'private' }
NonEffect >> reverseEffect [
	Error signal: 'Reversal cards can only be played on a valid effect position'
]
