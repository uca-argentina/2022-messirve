"
A permanent card that alternates the effects of the positions on the game board.
"
Class {
	#name : 'ReversalCard',
	#superclass : 'PermanentCard',
	#instVars : [
		'target'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
ReversalCard >> applyNegatedEffectOn: aRoundBoard [ 
	
	self applyReversalEffectOn: target from: aRoundBoard
]

{ #category : 'applying' }
ReversalCard >> applyReversalEffectOn: aTile from: aBoard [
	
	target := aTile.
	aBoard applyReverseEffectTo: target
]
