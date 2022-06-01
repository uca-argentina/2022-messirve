Class {
	#name : #EffectApplicator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
EffectApplicator >> apply: aBoardEffect on: statuses activatedBy: aStatus playedOn: aBoard and: aGame [

	^aBoardEffect
		applyOn: statuses
		activatedBy: aStatus
		playedOn: aBoard
		and: aGame
		appliedBy: self
]

{ #category : #'as yet unclassified' }
EffectApplicator >> applyBoostOf: aBoost on: statuses activatedBy: aStatus playedOn: aBoard and: aGame [

	| aDistance |
	aDistance := aBoard
		             calculateNewDistanceAfter: aStatus
		             rolled: aBoost
		             on: aGame.

	^aBoard advance: aStatus from: statuses to: aDistance
]
