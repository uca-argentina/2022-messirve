Class {
	#name : #NullEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
NullEffect >> applyOn: aCollection activatedBy: aSpaceShipStatus playedOn: aRoundBoard and: aMessirveSpaceRaceGame appliedBy: anEffectApplicator [

	Error signal: 'There was no effect previously played'
]