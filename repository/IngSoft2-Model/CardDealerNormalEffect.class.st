"
Specifies the standard outcomes of dealing cards without any special conditions or modifications.
"
Class {
	#name : 'CardDealerNormalEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'private' }
CardDealerNormalEffect >> applyCardDealerEffectTo: aStatus with: card from: statuses playedOn: aGame appliedBy: effectApplicator [

	^ effectApplicator
		  applyCardDealerEffectTo: aStatus
		  with: card
		  from: statuses
		  playedOn: aGame
]

{ #category : 'highlighting' }
CardDealerNormalEffect >> reverse [
	^CardDealerReverseEffect new.
]
