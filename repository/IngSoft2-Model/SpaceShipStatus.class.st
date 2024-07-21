"
Tracks the current status of a spaceship, including health, penalties, and power levels.
"
Class {
	#name : 'SpaceShipStatus',
	#superclass : 'Object',
	#instVars : [
		'spaceShip',
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SpaceShipStatus class >> with: aSpaceShip and: aSpaceShipDistance [

	^ self new initializeWith: aSpaceShip and: aSpaceShipDistance
]

{ #category : 'behavior' }
SpaceShipStatus >> conductTheTurnOn: game [ 
	game conductTheTurn.
]

{ #category : 'initialization' }
SpaceShipStatus >> initializeWith: aSpaceShip and: aSpaceShipPosition [

	spaceShip := aSpaceShip.
	position := aSpaceShipPosition.
]

{ #category : 'accessing' }
SpaceShipStatus >> isPenalized [

	^ false
]

{ #category : 'accessing' }
SpaceShipStatus >> lap [

	^ position lap
]

{ #category : 'accessing' }
SpaceShipStatus >> position [
	^ position
]

{ #category : 'accessing' }
SpaceShipStatus >> spaceShip [

	^ spaceShip
]

{ #category : 'accessing' }
SpaceShipStatus >> tile [

	^ position tile
]

{ #category : 'creation' }
SpaceShipStatus >> togglePenalizationWith: aSpaceShip and: aSpaceShipPosition [ 
	
	^ PenalizedSpaceShipStatus with: aSpaceShip and: aSpaceShipPosition
]
