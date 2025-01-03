Class {
	#name : #SpaceShipEngine,
	#superclass : #Object,
	#instVars : [
		'spaceShip',
		'enginePower'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpaceShipEngine class >> startedBy: aSpaceShip with: anEnginePower [

	^ self new initializeStartedBy: aSpaceShip with: anEnginePower
]

{ #category : #accessing }
SpaceShipEngine >> enginePower [

	^ enginePower
]

{ #category : #initialization }
SpaceShipEngine >> initializeStartedBy: aSpaceShip with: anEnginePower [

	spaceShip := aSpaceShip.
	enginePower := anEnginePower
]

{ #category : #accessing }
SpaceShipEngine >> spaceShip [

	^ spaceShip
]
