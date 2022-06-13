Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
OverloadCard >> activatedBy: aSpaceShip on: anEnginePowerApplicator [

	anEnginePowerApplicator powerEngineOf: aSpaceShip by: -1
]
