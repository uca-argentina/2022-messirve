Class {
	#name : #EnginePowerApplicator,
	#superclass : #Object,
	#instVars : [
		'globalEnginePower',
		'engines'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
EnginePowerApplicator class >> with: spaceShipNames [

	^ self new initializeWith: spaceShipNames
]

{ #category : #'as yet unclassified' }
EnginePowerApplicator >> accelerateAllEngines [

	globalEnginePower := globalEnginePower + 1
]

{ #category : #'as yet unclassified' }
EnginePowerApplicator >> applyCancellationTargetting: aCard in: aCardApplicator [

	aCardApplicator applyAllNegatedCardsOf: aCard
]

{ #category : #'as yet unclassified' }
EnginePowerApplicator >> applyEnginePowerTo: target afterPlaying: aCard on: aCardApplicator [

	aCard activatedTo: target on: self from: aCardApplicator
]

{ #category : #'as yet unclassified' }
EnginePowerApplicator >> engineOf: aSpaceShip [

	^ engines detect: [ :engine | engine spaceShip = aSpaceShip ]
]

{ #category : #initialization }
EnginePowerApplicator >> initializeWith: spaceShips [

	globalEnginePower := 0.
	engines := spaceShips collect: [ :spaceShip | 
		           SpaceShipEngine startedBy: spaceShip with: 0 ]
]

{ #category : #'as yet unclassified' }
EnginePowerApplicator >> powerEngineOf: aSpaceShip by: anEnginePower [
	
	| engineToPower newEnginePower newEngine |
	engineToPower := self engineOf: aSpaceShip.
	newEnginePower := engineToPower enginePower + anEnginePower.
	newEngine := SpaceShipEngine startedBy: aSpaceShip with: newEnginePower.
	engines replaceAll: engineToPower with: newEngine
]

{ #category : #'as yet unclassified' }
EnginePowerApplicator >> powerOf: aSpaceShip [

	^ (self engineOf: aSpaceShip) enginePower + globalEnginePower
]

{ #category : #'as yet unclassified' }
EnginePowerApplicator >> slowDownAllEngines [

	globalEnginePower := globalEnginePower - 1
]
