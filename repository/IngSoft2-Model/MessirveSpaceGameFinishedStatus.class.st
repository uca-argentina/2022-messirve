Class {
	#name : #MessirveSpaceGameFinishedStatus,
	#superclass : #Object,
	#instVars : [
		'winner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MessirveSpaceGameFinishedStatus class >> withWinner: aWinner [ 
	^self new initializeWithWinner: aWinner.
]

{ #category : #initialization }
MessirveSpaceGameFinishedStatus >> initializeWithWinner: aWinner [ 
	winner := aWinner.
]

{ #category : #testing }
MessirveSpaceGameFinishedStatus >> isFinished [
	^true.
]

{ #category : #accessing }
MessirveSpaceGameFinishedStatus >> winner [
	^ winner
]
