Class {
	#name : #GameplayTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameplayTests >> testASpaceGameCannotBePlayedMoreThanOnce [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aDie := RandomDie withSides: 3.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 1.

	aSpaceGame playGame.

	self
		should: [ aSpaceGame playGame ]
		raise: Error
		whoseDescriptionIncludes:
		'A game cannot be played after it has finished'
		description:
		'The Space Game has finished and cannot be played again'
]

{ #category : #tests }
GameplayTests >> testASpaceShipIsNotLongerInTheSamePositionAfterRollingADie [

	| aSpaceGame aBoard aDie initialPositionOfSpaceship finalPositionOfSpaceship |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aDie := RandomDie withSides: 3.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 1.

	initialPositionOfSpaceship := aSpaceGame positionOfSpaceship: 'Messi'.
	aSpaceGame playNextTurn.
	finalPositionOfSpaceship := aSpaceGame positionOfSpaceship: 'Messi'.

	self
		deny: initialPositionOfSpaceship
		equals: finalPositionOfSpaceship
]

{ #category : #tests }
GameplayTests >> testASpaceShipPlaysAGameWithOneDieAndTheGameFinishes [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aDie := RandomDie withSides: 3.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 1.

	aSpaceGame playGame.

	self assert: aSpaceGame isFinished
]

{ #category : #tests }
GameplayTests >> testASpaceShipWinsTheGameAndFinishesInTheRankingFirstPosition [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          HyperJumpEffectPosition with: { 1 . 30 }.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new. }
		          and: 50.
	aDiceCup := DiceCup withAll: {LoadedDie rolling: 1}.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy:
		              { 'Messi'. 'De Paul' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2.

	aSpaceGame playGame.

	self assert: (aSpaceGame ranking first spaceShip) equals: 'De Paul'.
]

{ #category : #tests }
GameplayTests >> testSixSpaceShipsPlayAGameWithThreeDiceAndTheGameFinishes [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aDiceCup := DiceCup withAll: { 
			            (RandomDie withSides: 3).
			            (RandomDie withSides: 5).
			            (RandomDie withSides: 7) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy:
		              { 'Messi'. 'De Paul'. 'Montiel'. 'Julian'. 'Milton'.
		              'Armani' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 1.

	aSpaceGame playGame.

	self assert: aSpaceGame isFinished
]

{ #category : #tests }
GameplayTests >> testTheRankingCanBeCheckedWhileTheGameIsStillInProgress [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new. }
		          and: 50.
	aDiceCup := DiceCup withAll: {LoadedDie rolling: 1}.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy:
		              { 'Messi'. 'De Paul' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame ranking first spaceShip) equals: 'Messi'.
]
