Class {
	#name : #MoonWalkEffectPosition,
	#superclass : #Object,
	#instVars : [
		'n'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
MoonWalkEffectPosition class >> withN: anN [
	^self new initializeWithN: anN.
]

{ #category : #applying }
MoonWalkEffectPosition >> applyEffectOn: aGame [
	aGame applyMoonWalkEffectWith: n.
]

{ #category : #initialization }
MoonWalkEffectPosition >> initializeWithN: anN [
	n := anN.
]
