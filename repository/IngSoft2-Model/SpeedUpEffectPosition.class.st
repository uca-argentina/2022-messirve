Class {
	#name : #SpeedUpEffectPosition,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
SpeedUpEffectPosition >> applyEffectOn: aGame [ 
	aGame applyBoostOf: 4.
]
