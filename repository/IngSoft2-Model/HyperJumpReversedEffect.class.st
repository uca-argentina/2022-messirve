"
Performs a reverse hyper jump, moving entities back to their previous locations on the game board.
"
Class {
	#name : 'HyperJumpReversedEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
HyperJumpReversedEffect >> applyEffectOf: aDistance on: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [ 

	^ effectApplicator
		  applyHyperJumpEffectWith: aDistance reverse
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame
]

{ #category : 'highlighting' }
HyperJumpReversedEffect >> reverse [
	^HyperJumpNormalEffect new.
]
