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

	^ self new initializeHanding: aCard
]

{ #category : #private }
CardDealerEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ effectApplicator applyCardDealerEffectTo: aStatus with: card from: statuses playedOn: aGame
]

{ #category : #initialization }
CardDealerEffect >> initializeHanding: aCard [

	card := aCard
]
