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

{ #category : #verification }
RoundBoard class >> assertValidBoardPositions: boardPositions [ 
		boardPositions size < 2
		ifTrue: [ Error signal: 'A board cannot have less than two positions' ]
]

{ #category : #verification }
RoundBoard class >> assertValidNumberOfPositions: numberOfPositions [
		numberOfPositions < 2
		ifTrue: [ Error signal: 'A board cannot have less than two positions' ]
]

{ #category : #verification }
RoundBoard class >> assertValidParsecs: someParsecs [ 
		someParsecs < 1
		ifTrue: [ Error signal: 'A board cannot be initialized with 0 or less parsecs' ]
]

{ #category : #'instance creation' }
RoundBoard class >> assignDistributedBoardPositionsAdaptedTo: numberOfPositions [

	| numberOfExtraPositions defaultBoardPositions |
	defaultBoardPositions := self createRandomBoardOf100Positions.

	numberOfExtraPositions := numberOfPositions - 100.
	1 to: numberOfExtraPositions do: [ :position | 
		defaultBoardPositions add:
			(defaultBoardPositions at: position % 100 + 1) ].
	^ defaultBoardPositions
]

{ #category : #initialization }
RoundBoard class >> boardWithOnly: effectPositions at: effectTileNumbers Of: numberOfPositions and: aNumberOfParsecs [

	| boardPositions |
	self assertValidParsecs: aNumberOfParsecs.
	self assertValidNumberOfPositions: numberOfPositions.

	boardPositions := self noEffectPositionBoardWith: numberOfPositions.
	1 to: effectTileNumbers size do: [ :i | 
		boardPositions
			at: (effectTileNumbers at: 1)
			put: (effectPositions at: 1) ].
	^ self new initializeWithPositions: boardPositions and: aNumberOfParsecs
]

{ #category : #'instance creation' }
RoundBoard class >> createRandomBoardOf100Positions [

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

{ #category : #'instance creation' }
RoundBoard class >> noEffectPositionBoardWith: numberOfTiles [

	| boardPositions |
	boardPositions := OrderedCollection new.
	1 to: numberOfTiles do: [ :i | 
	boardPositions add: NonEffectPosition new ].
	^ boardPositions
]

{ #category : #initialization }
RoundBoard class >> with: numberOfPositions and: aNumberOfParsecs [

	| defaultBoardPositions |
	self assertValidParsecs: aNumberOfParsecs.
	self assertValidNumberOfPositions: numberOfPositions.
	
	defaultBoardPositions := self assignDistributedBoardPositionsAdaptedTo:
		                         numberOfPositions.
	self assertValidBoardPositions: defaultBoardPositions.
	^ self new initializeWithPositions: defaultBoardPositions and: aNumberOfParsecs
]

{ #category : #initialization }
RoundBoard class >> withNoEffectsOf: numberOfPositions and: aNumberOfParsecs [

	| boardPositions |
	self assertValidParsecs: aNumberOfParsecs.
	self assertValidNumberOfPositions: numberOfPositions.

	boardPositions := self noEffectPositionBoardWith: numberOfPositions.
	^ self new
		  initializeWithPositions: boardPositions
		  and: aNumberOfParsecs
]

{ #category : #initialization }
RoundBoard class >> withPositions: boardPositions and: anAmountOfParsecs [

	self assertValidBoardPositions: boardPositions.
	self assertValidParsecs: anAmountOfParsecs.
	^ self new
		  initializeWithPositions: boardPositions
		  and: anAmountOfParsecs
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

	newPosition < 0 ifTrue: [ ^ 1 ].

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
