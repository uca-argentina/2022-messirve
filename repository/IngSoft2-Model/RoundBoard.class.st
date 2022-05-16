Class {
	#name : #RoundBoard,
	#superclass : #Object,
	#instVars : [
		'startingPosition',
		'boardEffects',
		'lastPosition',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
RoundBoard class >> assertValidPositions: boardPositions [ 
		boardPositions size < 2
		ifTrue: [ Error signal: 'A board cannot have less than two positions' ]
]

{ #category : #'instance creation' }
RoundBoard class >> assignDistributedBoardPositionsFrom: numberOfPositions [

	| numberOfExtraPositions defaultBoardPositions |
	defaultBoardPositions := self shuffleProbabilisticBoard.

	numberOfExtraPositions := numberOfPositions - 100.
	1 to: numberOfExtraPositions do: [ :position | 
		defaultBoardPositions add:
			(defaultBoardPositions at: position % 100 + 1) ].
	^ defaultBoardPositions
]

{ #category : #'instance creation' }
RoundBoard class >> shuffleProbabilisticBoard [

	| defaultBoardPositions |
	defaultBoardPositions := OrderedCollection new.
	1 to: 40 do: [ :i | defaultBoardPositions add: NonEffectPosition new ].
	1 to: 20 do: [ :i | defaultBoardPositions add: SpeedUpEffectPosition new ].
	1 to: 20 do: [ :i | defaultBoardPositions add: WormHoleEffectPosition new ].
	1 to: 10 do: [ :i | defaultBoardPositions add: (MoonWalkEffectPosition withN: (1 to: 10) atRandom) ].
	1 to:  8 do: [ :i | defaultBoardPositions add: (HyperJumpEffectPosition with: { 50 . 40 . 30 . 20 . 10 }) ].
	1 to:  2 do: [ :i | defaultBoardPositions add: NukeEffectPosition new ].
	
	defaultBoardPositions shuffle.
	^ defaultBoardPositions
]

{ #category : #'as yet unclassified' }
RoundBoard class >> with: numberOfPositions and: aNumberOfParsecs [

	| defaultBoardPositions |
	defaultBoardPositions := self assignDistributedBoardPositionsFrom:
		                         numberOfPositions.
	self assertValidPositions: defaultBoardPositions.
	^ self new initializeWithPositions: defaultBoardPositions and: aNumberOfParsecs
]

{ #category : #'as yet unclassified' }
RoundBoard class >> withPositions: boardPositions and: anAmountOfParsecs [ 
	self assertValidPositions: boardPositions.
	^self new initializeWithPositions: boardPositions and: anAmountOfParsecs .
]

{ #category : #accessing }
RoundBoard >> effectAppliedOnPosition: aPosition [
	^boardEffects at: aPosition.
]

{ #category : #accessing }
RoundBoard >> finalPositionWhenStartingAt: spaceShipPosition afterRolling: diceRoll [

	| newPosition |
	newPosition := spaceShipPosition + diceRoll.
	newPosition > lastPosition ifTrue: [ ^ newPosition % lastPosition ].

	newPosition < 0 ifTrue: [ ^ newPosition % lastPosition ].

	^ newPosition
]

{ #category : #initialization }
RoundBoard >> initializeWithPositions: boardPositions and: anAmountOfParsecs [
	
	startingPosition := 1 .
	boardEffects := boardPositions asOrderedCollection .
	lastPosition := boardPositions size.
	parsecs := anAmountOfParsecs. 
	
]

{ #category : #accessing }
RoundBoard >> lastPosition [
	^ lastPosition
]

{ #category : #accessing }
RoundBoard >> parsecsPerPosition [
	^parsecs / lastPosition.
]

{ #category : #accessing }
RoundBoard >> startingPosition [
	^ startingPosition
]
