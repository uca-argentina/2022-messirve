Class {
	#name : #WormHoleEffectPosition,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
WormHoleEffectPosition >> applyEffectOn: aGame [ 
	aGame applyBoostOf: -4.
]
