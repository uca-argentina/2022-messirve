Class {
	#name : #NukeEffectPosition,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
NukeEffectPosition >> applyEffectOn: aGame [ 
	aGame applyNukeEffect.
]
