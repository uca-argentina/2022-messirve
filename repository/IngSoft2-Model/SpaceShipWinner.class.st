Class {
	#name : #SpaceShipWinner,
	#superclass : #Object,
	#instVars : [
		'winnerExists',
		'spaceShipWinner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpaceShipWinner class >> initializeWithoutWinner [
	^self new initializeWithoutWinner.
]

{ #category : #initialization }
SpaceShipWinner >> initializeWithoutWinner [
	winnerExists := false.
]

{ #category : #'instance variables' }
SpaceShipWinner >> newWinnerBecomes: aSpaceShip [ 
	winnerExists := true.
	spaceShipWinner := aSpaceShip.
]

{ #category : #accessing }
SpaceShipWinner >> spaceShipWinner [
	^ spaceShipWinner
]

{ #category : #accessing }
SpaceShipWinner >> winnerExists [
	^ winnerExists
]
