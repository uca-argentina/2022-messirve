"
Removes cards from the players' inventories, altering the card distribution.
"
Class {
	#name : 'CardDealerReverseEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'private' }
CardDealerReverseEffect >> applyCardDealerEffectTo: aStatus with: card from: statuses playedOn: aGame appliedBy: effectApplicator [ 
	
	^ effectApplicator
		  applyReverseCardDealerEffectTo: aStatus
		  from: statuses
		  playedOn: aGame
]
