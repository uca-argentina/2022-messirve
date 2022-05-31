Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
SpeedUpEffect >> applyEffectOn: aGame [ 
	aGame applyBoostOf: 4.
]
