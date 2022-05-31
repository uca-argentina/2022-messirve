Class {
	#name : #NonEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
NonEffect >> applyEffectOn: aGame [

	aGame applyBoostOf: 0
]
