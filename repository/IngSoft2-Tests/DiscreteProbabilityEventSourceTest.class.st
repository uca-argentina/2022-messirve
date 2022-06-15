Class {
	#name : #DiscreteProbabilityEventSourceTest,
	#superclass : #TestCase,
	#instVars : [
		'soruce'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DiscreteProbabilityEventSourceTest >> assert: anEvent in: eventsDrawn between: start and: end [

	|amountOfAnEvent|
	amountOfAnEvent := eventsDrawn count: [ :event | event = anEvent ].
	self assert: (amountOfAnEvent between: start and: end).
]

{ #category : #asserting }
DiscreteProbabilityEventSourceTest >> assertAllIn: events are: anEvent [

	self assert: (events allSatisfy: [:event | event = anEvent])
]

{ #category : #asserting }
DiscreteProbabilityEventSourceTest >> assertNoneIn: events are: anEvent [

	self assert: (events noneSatisfy: [ :event | event = anEvent ])
]

{ #category : #tests }
DiscreteProbabilityEventSourceTest >> testAProbabilisticEventCannotBeCreatedWithAProbabilityHigherThanOne [

	self
		should: [ 
			ProbabilityEvent of: (SpeedUpEffect new) with: 2 ]
		raise: Error
		whoseDescriptionIncludes: 'Probability must be between 0 and 1'
		description:
		'Probability of an event must be between 0 and 1'
]

{ #category : #tests }
DiscreteProbabilityEventSourceTest >> testAProbabilisticEventCannotBeCreatedWithAProbabilityLowerThanOne [

	self
		should: [ 
			ProbabilityEvent of: (SpeedUpEffect new) with: -2 ]
		raise: Error
		whoseDescriptionIncludes: 'Probability must be between 0 and 1'
		description:
		'Probability of an event must be between 0 and 1'
]

{ #category : #tests }
DiscreteProbabilityEventSourceTest >> testDrawingFiftyThousandOfBoardEffectsWithoutAtomicBombDoesNotDrawAnyAtmoicBomb [

	| source events speedUpEffect wormholeEffect cardDealerEffect atomicBombEffect probabilityEvents discreteProbabilityDistribution |
	speedUpEffect := SpeedUpEffect new.
	wormholeEffect := WormHoleEffect new.
	cardDealerEffect := CardDealerEffect new.
	atomicBombEffect := AtomicBombEffect new.
	probabilityEvents := { 
		                     (ProbabilityEvent of: speedUpEffect with: 0.2).
		                     (ProbabilityEvent of: wormholeEffect with: 0.1).
		                     (ProbabilityEvent of: wormholeEffect with: 0.7).
		                     (ProbabilityEvent of: atomicBombEffect with: 0) }.

	discreteProbabilityDistribution := DiscreteProbabilityDistribution withAll: probabilityEvents.
	source := DiscreteProbabilityEventSource with: discreteProbabilityDistribution.

	events := source next: 50000.

	self assertNoneIn: events are: atomicBombEffect
]

{ #category : #tests }
DiscreteProbabilityEventSourceTest >> testDrawingOneHundredThousandsOfBoardEffectsGivesTwentyPercentOfSpeedUpTenOfWormholeAndSeventyPercentOfCardDealerEvents [

	| source events speedUpEffect wormholeEffect cardDealerEffect probabilityEvents discreteProbabilityDistribution |
	speedUpEffect := SpeedUpEffect new.
	wormholeEffect := WormHoleEffect new.
	cardDealerEffect := CardDealerEffect new.
	probabilityEvents := { 
		                     (ProbabilityEvent of: speedUpEffect with: 0.2).
		                     (ProbabilityEvent of: wormholeEffect with: 0.1).
		                     (ProbabilityEvent of: cardDealerEffect with: 0.7)}.

	discreteProbabilityDistribution := DiscreteProbabilityDistribution withAll: probabilityEvents.
	source := DiscreteProbabilityEventSource with: discreteProbabilityDistribution.

	events := source next: 100000.

	self assert: speedUpEffect in: events between: 19000 and: 21000.
	self assert: wormholeEffect in: events between: 9000 and: 11000.
	self assert: cardDealerEffect in: events between: 69000 and: 71000.
]

{ #category : #tests }
DiscreteProbabilityEventSourceTest >> testDrawingOneHundredThousandsOfBoardEffectsGivesTwentyPercentOfSpeedUpTenOfWormholeSeventyPercentOfCardDealerEventsAndZeroOfNonEffect [

	| source events speedUpEffect wormholeEffect cardDealerEffect nonEffect probabilityEvents discreteProbabilityDistribution |
	speedUpEffect := SpeedUpEffect new.
	wormholeEffect := WormHoleEffect new.
	cardDealerEffect := CardDealerEffect new.
	nonEffect := NonEffect new.
	probabilityEvents := { 
		                     (ProbabilityEvent of: speedUpEffect with: 0.2).
							    	(ProbabilityEvent of: nonEffect with: 0).
		                     (ProbabilityEvent of: wormholeEffect with: 0.1).
		                     (ProbabilityEvent of: cardDealerEffect with: 0.7)}.

	discreteProbabilityDistribution := DiscreteProbabilityDistribution withAll: probabilityEvents.
	source := DiscreteProbabilityEventSource with: discreteProbabilityDistribution.

	events := source next: 100000.

	self assert: speedUpEffect in: events between: 19000 and: 21000.
	self assert: wormholeEffect in: events between: 9000 and: 11000.
	self assert: cardDealerEffect in: events between: 69000 and: 71000.
	self assertNoneIn: events are: nonEffect
]

{ #category : #tests }
DiscreteProbabilityEventSourceTest >> testSourceProvidesSpeedUpTenTimesWhenEventDistributionHasNoProbabilityForWormhole [

	| events speedUpEffect wormholeEffect discreteProbabilityDistribution source speedUpProbabilityEvent wormholeProbabilityEvent |
	speedUpEffect := SpeedUpEffect new.
	wormholeEffect := WormHoleEffect new.
	speedUpProbabilityEvent := ProbabilityEvent of: speedUpEffect with: 1.
	wormholeProbabilityEvent := ProbabilityEvent of: wormholeEffect with: 0.


	discreteProbabilityDistribution := DiscreteProbabilityDistribution withAll: {speedUpProbabilityEvent. wormholeProbabilityEvent}.
	source := DiscreteProbabilityEventSource with: discreteProbabilityDistribution.
	
	events := source next: 10.
	
	self assertAllIn: events are: speedUpEffect.
	self assertNoneIn: events are: wormholeEffect
]

{ #category : #tests }
DiscreteProbabilityEventSourceTest >> testSourceProvidesTenTimesTheSameEventForASingleEventDistribution [

	| effects speedUpEffect discreteProbabilityDistribution source speedUpProbabilityEvent |
	speedUpEffect := SpeedUpEffect new.
	speedUpProbabilityEvent := ProbabilityEvent of: speedUpEffect with: 1.
	discreteProbabilityDistribution := DiscreteProbabilityDistribution 
		                                   withAll:
		                                   { speedUpProbabilityEvent }.
	source := DiscreteProbabilityEventSource with:
		          discreteProbabilityDistribution.

	effects := source next: 10.

	self assertAllIn: effects are: speedUpEffect
]

{ #category : #tests }
DiscreteProbabilityEventSourceTest >> testTwoProbabilityEventsWithTheirSumHigherThanOneCannotFormADiscreteProbabilityDistribution [

	| speedUpEffect wormholeEffect speedUpProbabilityEvent wormholeProbabilityEvent |
	speedUpEffect := SpeedUpEffect new.
	wormholeEffect := WormHoleEffect new.
	speedUpProbabilityEvent := ProbabilityEvent of: speedUpEffect with: 1.
	wormholeProbabilityEvent := ProbabilityEvent of: wormholeEffect with: 1.

	self
		should: [ 
			DiscreteProbabilityDistribution withAll: { 
					speedUpProbabilityEvent.
					wormholeProbabilityEvent } ]
		raise: Error
		whoseDescriptionIncludes: 'The sum of probabilities must be 1'
		description: 'Sum of probabilities must be one'
]

{ #category : #tests }
DiscreteProbabilityEventSourceTest >> testTwoProbabilityEventsWithTheirSumLowerThanOneCannotFormADiscreteProbabilityDistribution [

	| speedUpEffect wormholeEffect speedUpProbabilityEvent wormholeProbabilityEvent |
	speedUpEffect := SpeedUpEffect new.
	wormholeEffect := WormHoleEffect new.
	speedUpProbabilityEvent := ProbabilityEvent of: speedUpEffect with: 0.2.
	wormholeProbabilityEvent := ProbabilityEvent of: wormholeEffect with: 0.1.

	self
		should: [ 
			DiscreteProbabilityDistribution withAll: { 
					speedUpProbabilityEvent.
					wormholeProbabilityEvent } ]
		raise: Error
		whoseDescriptionIncludes: 'The sum of probabilities must be 1'
		description: 'Sum of probabilities must be one'
]
