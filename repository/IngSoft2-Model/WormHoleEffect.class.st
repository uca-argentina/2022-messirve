Class {
	#name : #WormHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
WormHoleEffect >> applyEffectOn: aGame [ 
	aGame applyBoostOf: -4.
]
