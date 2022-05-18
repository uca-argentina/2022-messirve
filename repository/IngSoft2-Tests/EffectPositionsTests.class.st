Class {
	#name : #EffectPositionsTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectPositionsTests >> testASpaceShipLandsOnASpeedUpPositionAndAdvances4Spaces [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          SpeedUpEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aDie := LoadedDie rolling: 1.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 1.
	self deny: aSpaceGame isFinished
]

{ #category : #tests }
EffectPositionsTests >> testASpaceShipLandsOnAWormHolePositionAndGoesBack4Spaces [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          WormHoleEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aDie := LoadedDie rolling: 1.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 3.
	self assert: (aSpaceGame lapsOfSpaceship: 'Messi') equals: 1.
	self deny: aSpaceGame isFinished
]

{ #category : #tests }
EffectPositionsTests >> testASpaceShipThatLandsOnAMoonWalkTakesEverySpaceShipButTheSpaceShipInCurrentTurnBackNPositions [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          (MoonWalkEffectPosition withN: 3).
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aDie := LoadedDie rolling: 1.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul'. 'Armani' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 5.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'De Paul') equals: 4.
	self assert: (aSpaceGame lapsOfSpaceship: 'De Paul') equals: 1.

	self assert: (aSpaceGame positionOfSpaceship: 'Armani') equals: 4.
	self assert: (aSpaceGame lapsOfSpaceship: 'Armani') equals: 1.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 2.
	self assert: (aSpaceGame lapsOfSpaceship: 'Messi') equals: 1
]

{ #category : #tests }
EffectPositionsTests >> testASpaceShipThatLandsOnANukeTakesEverySpaceShipBackToPositionOne [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NukeEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aDie := LoadedDie rolling: 1.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul'. 'Armani' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 5.

	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'De Paul') equals: 2.
	self assert: (aSpaceGame positionOfSpaceship: 'Armani') equals: 2.
	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 2.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'De Paul') equals: 1.
	self assert: (aSpaceGame positionOfSpaceship: 'Armani') equals: 1.
	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 1
]

{ #category : #tests }
EffectPositionsTests >> testASpaceshipCannotBeAffectedByAChainedEffect [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          SpeedUpEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          SpeedUpEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: 1) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 6
]

{ #category : #tests }
EffectPositionsTests >> testASpaceshipLandsOnAHyperJumpPositionAfterAnotherSpaceshipAndAdvances20Parsecs [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          (HyperJumpEffectPosition with: { 30. 20. 10 }).
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: 1) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' . 'De Paul' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2.

	aSpaceGame playGame.
	self assert: aSpaceGame isFinished.
]

{ #category : #tests }
EffectPositionsTests >> testASpaceshipLandsOnAHyperJumpPositionAndAdvances30Parsecs [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          (HyperJumpEffectPosition with: { 30. 20. 10 }).
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: 1) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 5
]

{ #category : #tests }
EffectPositionsTests >> testASpaceshipLandsOnAHyperJumpPositionButTheParsecsAwardedAreNotEnoughToMove [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          (HyperJumpEffectPosition with: { 3. 20. 10 }).
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: 1) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 2
]

{ #category : #tests }
EffectPositionsTests >> testASpaceshipThatMovesForwardFourAfterLandingOnASpeedUpDoesNotGoBackFourAfterLandingOnAWormHoleOnTheSameTurn [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          SpeedUpEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          WormHoleEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: 1) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 6
]

{ #category : #tests }
EffectPositionsTests >> testSpaceShipsLandOnHyperJumpPositionFourTimesAndTheLastOneIsAtTheSamePositionAsTheFirstOne [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          (HyperJumpEffectPosition with: { 30. 20. 10 }).
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: 1) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' . 'De Paul' . 'Paredes' . 'El Dibu' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2.

	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.
	
	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 5.
	self assert: (aSpaceGame positionOfSpaceship: 'De Paul') equals: 4.
	self assert: (aSpaceGame positionOfSpaceship: 'Paredes') equals: 3.
	self assert: (aSpaceGame positionOfSpaceship: 'El Dibu') equals: 5.
]
