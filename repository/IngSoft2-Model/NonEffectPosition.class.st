Class {
	#name : #NonEffectPosition,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
NonEffectPosition >> applyEffectOn: aGame [ 
	aGame applyBoostOf: 0.
]
