"
Defines the impact or consequences of the card dealing process on the game's progression.
"
Class {
	#name : 'CardDealerEffect',
	#superclass : 'Object',
	#instVars : [
		'card',
		'effectOrientation'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
CardDealerEffect class >> handing: aCard [

	^ self new initializeHanding: { aCard }
]

{ #category : 'as yet unclassified' }
CardDealerEffect class >> handingRandomCards [

	^ self new initializeHanding: { CancellationCard new . AccelerationCard new . OverloadCard new . SpeedCard new . RedoCard new . RepeatCard new }
]

{ #category : 'private' }
CardDealerEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ effectOrientation
		  applyCardDealerEffectTo: aStatus
		  with: card atRandom
		  from: statuses
		  playedOn: aGame
		  appliedBy: effectApplicator 
]

{ #category : 'initialization' }
CardDealerEffect >> initializeHanding: aCard [

	card := aCard.
	effectOrientation := CardDealerNormalEffect new.
]

{ #category : 'private' }
CardDealerEffect >> reverseEffect [
	effectOrientation := effectOrientation reverse.
]
