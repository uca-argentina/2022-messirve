"
Represents the game's state at the start of a player's turn, initiating turn-specific actions.
"
Class {
	#name : 'MessirveSpaceGameStartOfTurnStatus',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
MessirveSpaceGameStartOfTurnStatus >> isFinished [

	^ false
]

{ #category : 'testing' }
MessirveSpaceGameStartOfTurnStatus >> winner [

	Error signal: 'There is no winner'
]
