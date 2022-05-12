Class {
	#name : #MessirveSpaceGameStartOfTurnStatus,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
MessirveSpaceGameStartOfTurnStatus >> canApplyMovement [
	^false
]

{ #category : #testing }
MessirveSpaceGameStartOfTurnStatus >> isFinished [
	^false
]

{ #category : #testing }
MessirveSpaceGameStartOfTurnStatus >> winner [ 
	Error signal: 'There is no winner'
]
