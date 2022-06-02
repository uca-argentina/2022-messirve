Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
SpeedUpEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^effectApplicator
		applyBoostOf: 4
		on: statuses
		activatedBy: aStatus
		playedOn: aBoard
		and: aGame
]
