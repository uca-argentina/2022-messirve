Class {
	#name : #MoonWalkEffect,
	#superclass : #Object,
	#instVars : [
		'backwardPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
MoonWalkEffect class >> assertValidPositionsGoingBackOf: anAmountOfPositions [

	anAmountOfPositions < 1 ifTrue: [ 
		Error signal: 'Amount of back positions must be higher than 0' ]
]

{ #category : #calculating }
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

{ #category : #initialization }
MoonWalkEffect class >> randomlyDistributed [

	| takingBackBetweenOneAndTen |
	takingBackBetweenOneAndTen := self
		                              obtainRandomTakingBackBetween: 1
		                              and: 10.

	^ self new initializeTakingBack: (takingBackBetweenOneAndTen at: 1)
]

{ #category : #initialization }
MoonWalkEffect class >> takingBack: anAmountOfPositions [

	self assertValidPositionsGoingBackOf: anAmountOfPositions.
	^ self new initializeTakingBack: anAmountOfPositions
]

{ #category : #private }
MoonWalkEffect >> applyOn: statuses activatedBy: aStatus playedOn: aBoard and: aGame appliedBy: effectApplicator [

	^ effectApplicator
		  applyMoonWalkOf: -1 * backwardPositions
		  on: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame
]

{ #category : #initialization }
MoonWalkEffect >> initializeTakingBack: backPositions [

	backwardPositions := backPositions
]
