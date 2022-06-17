Class {
	#name : #CardDealerEffect,
	#superclass : #Object,
	#instVars : [
		'card'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
CardDealerEffect class >> handing: aCard [

	^ self new initializeHanding: { aCard }
]

{ #category : #'as yet unclassified' }
CardDealerEffect class >> handingRandomCards [

	^ self new initializeHanding: { CancellationCard new . AccelerationCard new . OverloadCard new . SpeedCard new . RedoCard new . RepeatCard new }
]

{ #category : #private }
CardDealerEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ effectApplicator applyCardDealerEffectTo: aStatus with: (card atRandom) from: statuses playedOn: aGame
]

{ #category : #initialization }
CardDealerEffect >> initializeHanding: aCard [

	card := aCard
]
