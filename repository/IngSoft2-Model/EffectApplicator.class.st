Class {
	#name : #EffectApplicator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
EffectApplicator >> apply: aBoardEffect on: statuses activatedBy: aStatus playedOn: aBoard and: aGame [

	^ aBoardEffect
		  applyOn: statuses
		  activatedBy: aStatus
		  playedOn: aBoard
		  and: aGame
		  appliedBy: self
]

{ #category : #applying }
EffectApplicator >> applyAtomicBombOn: statuses playedOn: aBoard [

	| newStatuses |
	^ newStatuses := statuses collect: [ :status | 
		                 SpaceShipStatus
			                 with: status spaceShip
			                 and:
			                 (SpaceShipPosition
				                  with: 1
				                  and: status lap
				                  on: aBoard) ]
]

{ #category : #applying }
EffectApplicator >> applyBoostOf: aBoost on: statuses activatedBy: aStatus playedOn: aBoard and: aGame [

	| aDistance |
	aDistance := aBoard
		             newDistanceAfter: aStatus
		             rolled: aBoost
		             on: aGame.

	^ aBoard advance: aStatus from: statuses to: aDistance
]

{ #category : #applying }
EffectApplicator >> applyHyperJumpEffectWith: aBoost on: statuses activatedBy: aStatus playedOn: aBoard and: aGame [

	| aDistance positionLength aPosition |
	positionLength := aBoard parsecsPerPosition.
	aDistance := aBoost // positionLength.

	aPosition := aBoard
		             newDistanceAfter: aStatus
		             rolled: aDistance
		             on: aGame.

	^ aBoard advance: aStatus from: statuses to: aPosition
]

{ #category : #applying }
EffectApplicator >> applyMoonWalkOf: somePositions on: statuses activatedBy: aStatus playedOn: aBoard and: aGame [

	| currentDistance newStatuses spaceShipPlaying |
	currentDistance := aStatus position.

	newStatuses := statuses collect: [ :status | 
		               SpaceShipStatus
			               with: status spaceShip
			               and: (SpaceShipPosition
					                with:
					                (aBoard
						                 positionAfter: status
						                 rolled: somePositions)
					                and:
					                (aBoard
						                 lapAfter: status
						                 rolled: somePositions
						                 on: aGame)
					                on: aBoard) ].

	spaceShipPlaying := self
		                    statusOf: aStatus spaceShip
		                    from: newStatuses.

	^ aBoard
		  advance: spaceShipPlaying
		  from: newStatuses
		  to: currentDistance
]

{ #category : #applying }
EffectApplicator >> statusOf: aSpaceShip from: statuses [

	^ statuses detect: [ :status | status spaceShip = aSpaceShip ]
]
