"
Executes a standard hyper jump, moving entities to predetermined locations on the game board.
"
Class {
	#name : 'HyperJumpNormalEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
HyperJumpNormalEffect >> applyEffectOf: aDistance on: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [ 

	^ effectApplicator
		  applyHyperJumpEffectWith: aDistance
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame
]

{ #category : 'highlighting' }
HyperJumpNormalEffect >> reverse [
	^HyperJumpReversedEffect new. 
]
