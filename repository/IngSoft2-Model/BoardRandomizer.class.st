Class {
	#name : #BoardRandomizer,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
BoardRandomizer >> assignDistributedBoardPositionsAdaptedTo: numberOfPositions [

	| source atomicBomb hyperJumpEffect moonwalkEffect speedUpEffect wormholeEffect cardDealerEffect nonEffect probabilityEvents discreteProbabilityDistribution |
	atomicBomb := AtomicBombEffect new.
	cardDealerEffect := CardDealerEffect handingRandomCards.
	hyperJumpEffect := HyperJumpEffect with: { 50. 40. 30. 20. 10 } and: { 10 . 8 . 7 . 6 . 5 }.
	moonwalkEffect := MoonWalkEffect randomlyDistributed.
	nonEffect := NonEffect new.
	speedUpEffect := SpeedUpEffect new.
	wormholeEffect := WormHoleEffect new.

	nonEffect := NonEffect new.
	probabilityEvents := { 
		                     (ProbabilityEvent of: atomicBomb with: 0.02).
		                     (ProbabilityEvent
			                      of: cardDealerEffect
			                      with: 0.1).
		                     (ProbabilityEvent
			                      of: hyperJumpEffect
			                      with: 0.08).
		                     (ProbabilityEvent of: moonwalkEffect with: 0.1).
		                     (ProbabilityEvent of: nonEffect with: 0.3).
		                     (ProbabilityEvent of: speedUpEffect with: 0.2).
		                     (ProbabilityEvent of: wormholeEffect with: 0.2) }.

	discreteProbabilityDistribution := DiscreteProbabilityDistribution 
		                                   withAll: probabilityEvents.
	source := DiscreteProbabilityEventSource with:
		          discreteProbabilityDistribution.

	^ source next: numberOfPositions
]
