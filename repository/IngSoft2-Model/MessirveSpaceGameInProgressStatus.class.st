Class {
	#name : #MessirveSpaceGameInProgressStatus,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
MessirveSpaceGameInProgressStatus >> isFinished [
	^false
]

{ #category : #testing }
MessirveSpaceGameInProgressStatus >> winner [ 
	Error signal: 'There is no winner'
]
