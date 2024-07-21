"
Represents the status of a spaceship that is penalized, affecting its performance or abilities.
"
Class {
	#name : 'PenalizedSpaceShipStatus',
	#superclass : 'Object',
	#instVars : [
		'spaceShip',
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
PenalizedSpaceShipStatus class >> with: aSpaceShip and: aSpaceShipDistance [

	^ self new initializeWith: aSpaceShip and: aSpaceShipDistance
]

{ #category : 'behavior' }
PenalizedSpaceShipStatus >> conductTheTurnOn: game [ 
	
	game handlePenalizedPlayer.
]

{ #category : 'initialization' }
PenalizedSpaceShipStatus >> initializeWith: aSpaceShip and: aSpaceShipPosition [

	spaceShip := aSpaceShip.
	position := aSpaceShipPosition.
]

{ #category : 'accessing' }
PenalizedSpaceShipStatus >> isPenalized [

	^ true
]

{ #category : 'accessing' }
PenalizedSpaceShipStatus >> lap [

	^ position lap
]

{ #category : 'accessing' }
PenalizedSpaceShipStatus >> position [
	^ position
]

{ #category : 'accessing' }
PenalizedSpaceShipStatus >> spaceShip [

	^ spaceShip
]

{ #category : 'accessing' }
PenalizedSpaceShipStatus >> tile [

	^ position tile
]

{ #category : 'creation' }
PenalizedSpaceShipStatus >> togglePenalizationWith: aSpaceShip and: aSpaceShipPosition [ 
	
	^ SpaceShipStatus with: aSpaceShip and: aSpaceShipPosition
]
