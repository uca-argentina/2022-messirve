Class {
	#name : #NonEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
NonEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ statuses copy.
]
