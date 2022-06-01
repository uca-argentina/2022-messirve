Class {
	#name : #NonEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
NonEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ effectApplicator
		  applyBoostOf: 0
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame
]
