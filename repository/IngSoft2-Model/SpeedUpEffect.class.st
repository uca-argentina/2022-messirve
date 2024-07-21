"
Moves a player forward a few positions on the game board.
"
Class {
	#name : 'SpeedUpEffect',
	#superclass : 'Object',
	#instVars : [
		'effectOrientation'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'private' }
SpeedUpEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ effectOrientation
		  applyEffectOf: 4
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame
		  appliedBy: effectApplicator
]

{ #category : 'initialization' }
SpeedUpEffect >> initialize [ 

	effectOrientation := SpeedUpNormalEffect new. 
]

{ #category : 'private' }
SpeedUpEffect >> reverseEffect [
	effectOrientation := effectOrientation reverse.
]
