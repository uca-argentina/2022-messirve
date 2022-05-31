Class {
	#name : #BoardRandomizer,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
BoardRandomizer >> assignDistributedBoardPositionsAdaptedTo: numberOfPositions [

	| numberOfExtraPositions defaultBoardPositions |
	defaultBoardPositions := self createRandomBoardOf100Positions.

	numberOfExtraPositions := numberOfPositions - 100.
	1 to: numberOfExtraPositions do: [ :position | 
		defaultBoardPositions add:
			(defaultBoardPositions at: position % 100 + 1) ].
	^ defaultBoardPositions
]

{ #category : #creation }
BoardRandomizer >> createRandomBoardOf100Positions [

	| defaultBoardPositions |
	defaultBoardPositions := OrderedCollection new.
	1 to: 40 do: [ :i | defaultBoardPositions add: NonEffect new ].
	1 to: 20 do: [ :i | defaultBoardPositions add: SpeedUpEffect new ].
	1 to: 20 do: [ :i | defaultBoardPositions add: WormHoleEffect new ].
	1 to: 10 do: [ :i | defaultBoardPositions add: (MoonWalkEffect takingBack: (1 to: 10) atRandom) ].
	1 to:  8 do: [ :i | defaultBoardPositions add: (HyperJumpEffect with: { 50 . 40 . 30 . 20 . 10 }) ].
	1 to:  2 do: [ :i | defaultBoardPositions add: AtomicBombEffect new ].
	
	defaultBoardPositions shuffle.
	^ defaultBoardPositions
]
