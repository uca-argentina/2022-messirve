"
Denotes the game's state during a player's turn, tracking actions and events.
"
Class {
	#name : 'MessirveSpaceGameTurnInProgressStatus',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
MessirveSpaceGameTurnInProgressStatus >> canApplyMovement [

	^ true
]

{ #category : 'testing' }
MessirveSpaceGameTurnInProgressStatus >> isFinished [

	^ false
]
