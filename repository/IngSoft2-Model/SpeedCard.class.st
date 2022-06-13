Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedCard >> activatedBy: aSpaceShip on: anEnginePowerApplicator [

	anEnginePowerApplicator powerEngineOf: aSpaceShip by: 1
]
