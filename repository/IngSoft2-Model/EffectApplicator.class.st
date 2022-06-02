Class {
	#name : #EffectApplicator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
EffectApplicator >> apply: aBoardEffect on: statuses activatedBy: aStatus playedOn: aBoard and: aGame [

	^aBoardEffect
		applyOn: statuses
		activatedBy: aStatus
		playedOn: aBoard
		and: aGame
		appliedBy: self
]

{ #category : #'as yet unclassified' }
EffectApplicator >> applyAtomicBombOn: statuses playedOn: aBoard [

	| newStatuses |
	^newStatuses := statuses collect: [ :status | 
		               SpaceShipStatus
			               with: status spaceShip
			               and:
			               (SpaceShipDistance
				                with: 1
				                and: status lap
				                on: aBoard) ]
]

{ #category : #'as yet unclassified' }
EffectApplicator >> applyBoostOf: aBoost on: statuses activatedBy: aStatus playedOn: aBoard and: aGame [

	| aDistance  |

	aDistance := aBoard
		             calculateNewDistanceAfter: aStatus
		             rolled: aBoost
		             on: aGame.

	^aBoard advance: aStatus from: statuses to: aDistance
]

{ #category : #'as yet unclassified' }
EffectApplicator >> applyMoonWalkOf: somePositions on: statuses activatedBy: aStatus playedOn: aBoard and: aGame [

	| statusWithMoonWalkApplied newStatuses |
	newStatuses := statuses collect: [ :status | 
		               SpaceShipStatus
			               with: status spaceShip
			               and: (SpaceShipDistance
					                with: (aBoard
							                 finalPositionWhenStartingAt: status position
							                 afterRolling: somePositions)
					                and: status lap
					                on: aBoard) ].

	statusWithMoonWalkApplied := newStatuses detect: [ :status | 
		                             status spaceShip = aStatus spaceShip ].
	^ aBoard
		  advance: statusWithMoonWalkApplied
		  from: newStatuses
		  to: aStatus distance
]
