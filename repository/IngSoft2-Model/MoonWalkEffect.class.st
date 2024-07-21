"
Moves players backward on the game board, simulating a moonwalk effect.
"
Class {
	#name : 'MoonWalkEffect',
	#superclass : 'Object',
	#instVars : [
		'backwardPositions',
		'effectOrientation'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
MoonWalkEffect class >> assertValidPositionsGoingBackOf: anAmountOfPositions [

	anAmountOfPositions < 1 ifTrue: [ 
		Error signal: 'Amount of back positions must be higher than 0' ]
]

{ #category : 'calculating' }
MoonWalkEffect class >> obtainRandomTakingBackBetween: start and: end [

	| source probabilityEvents discreteProbabilityDistribution |

	probabilityEvents := OrderedCollection new.
	start to: end do: [ :i | 
		probabilityEvents add: (ProbabilityEvent of: i with: start / end) ].

	discreteProbabilityDistribution := DiscreteProbabilityDistribution 
		                                   withAll: probabilityEvents.
	source := DiscreteProbabilityEventSource with:
		          discreteProbabilityDistribution.

	^ source next: 1
]

{ #category : 'initialization' }
MoonWalkEffect class >> randomlyDistributed [

	| takingBackBetweenOneAndTen |
	takingBackBetweenOneAndTen := self
		                              obtainRandomTakingBackBetween: 1
		                              and: 10.

	^ self new initializeTakingBack: (takingBackBetweenOneAndTen at: 1)
]

{ #category : 'initialization' }
MoonWalkEffect class >> takingBack: anAmountOfPositions [

	self assertValidPositionsGoingBackOf: anAmountOfPositions.
	^ self new initializeTakingBack: anAmountOfPositions
]

{ #category : 'private' }
MoonWalkEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ effectOrientation
		  applyEffectOf: backwardPositions
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame
		  appliedBy: effectApplicator
]

{ #category : 'initialization' }
MoonWalkEffect >> initializeTakingBack: backPositions [
	
	effectOrientation := MoonWalkNormalEffect new.
	backwardPositions := backPositions
]

{ #category : 'private' }
MoonWalkEffect >> reverseEffect [
	effectOrientation := effectOrientation reverse.
]
