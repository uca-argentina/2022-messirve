Class {
	#name : #EffectPositionsTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectPositionsTests >> testASpaceShipLandsOnASpeedUpPositionAndAdvancesFourSpaces [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          boardWithOnly: { SpeedUpEffectPosition new }
		          at: { 2 }
		          Of: 5
		          and: 100.
	aDie := LoadedDie rolling: { 1 }.

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
EffectPositionsTests >> testASpaceShipLandsOnAWormHolePositionAndGoesBackFourSpaces [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          boardWithOnly: { WormHoleEffectPosition new }
		          at: { 2 }
		          Of: 5
		          and: 100.
	aDie := LoadedDie rolling: { 1 }.

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
EffectPositionsTests >> testASpaceShipThatLandsOnANukeAfterFinishingTheFirstLapTakesEverySpaceShipBackToPositionOneButMaintainsItsAchievedLaps [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          boardWithOnly: { NukeEffectPosition new }
		          at: { 1 }
		          Of: 3
		          and: 100.
	aDie := LoadedDie rolling: { 1. 1. 1. 2 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'De Paul'. 'Armani'. 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 5.

	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'De Paul') equals: 2.
	self assert: (aSpaceGame lapsOfSpaceship: 'De Paul') equals: 1.
	self assert: (aSpaceGame positionOfSpaceship: 'Armani') equals: 2.
	self assert: (aSpaceGame lapsOfSpaceship: 'Armani') equals: 1.
	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 2.
	self assert: (aSpaceGame lapsOfSpaceship: 'Messi') equals: 1.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'De Paul') equals: 1.
	self assert: (aSpaceGame lapsOfSpaceship: 'De Paul') equals: 2.
	self assert: (aSpaceGame positionOfSpaceship: 'Armani') equals: 1.
	self assert: (aSpaceGame lapsOfSpaceship: 'Armani') equals: 1.
	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 1.
	self assert: (aSpaceGame lapsOfSpaceship: 'Messi') equals: 1
]

{ #category : #tests }
EffectPositionsTests >> testASpaceShipThatLandsOnANukeTakesEverySpaceShipBackToPositionOne [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          boardWithOnly: { NukeEffectPosition new }
		          at: { 3 }
		          Of: 4
		          and: 100.
	aDie := LoadedDie rolling: { 1 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul'. 'Armani' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 5.

	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'De Paul') equals: 2.
	self assert: (aSpaceGame lapsOfSpaceship: 'De Paul') equals: 1.
	self assert: (aSpaceGame positionOfSpaceship: 'Armani') equals: 2.
	self assert: (aSpaceGame lapsOfSpaceship: 'Armani') equals: 1.
	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 2.
	self assert: (aSpaceGame lapsOfSpaceship: 'Messi') equals: 1.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'De Paul') equals: 1.
	self assert: (aSpaceGame lapsOfSpaceship: 'De Paul') equals: 1.
	self assert: (aSpaceGame positionOfSpaceship: 'Armani') equals: 1.
	self assert: (aSpaceGame lapsOfSpaceship: 'Armani') equals: 1.
	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 1.
	self assert: (aSpaceGame lapsOfSpaceship: 'Messi') equals: 1
]

{ #category : #tests }
EffectPositionsTests >> testASpaceshipCannotBeAffectedByAChainedEffect [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          boardWithOnly: { SpeedUpEffectPosition new . SpeedUpEffectPosition new}
		          at: { 2 . 6 }
		          Of: 7
		          and: 100.

	aDiceCup := DiceCup withAll: { (LoadedDie rolling: { 1 }) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 6
]

{ #category : #tests }
EffectPositionsTests >> testASpaceshipLandsOnAHyperJumpPositionAfterAnotherSpaceshipAndAdvancesTwentyParsecs [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          boardWithOnly: { HyperJumpEffectPosition with: { 30. 20. 10 } }
		          at: { 2 }
		          Of: 10
		          and: 100.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: { 1 }) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2.

	aSpaceGame playNextTurn.
	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 5.

	aSpaceGame playNextTurn.
	self assert: (aSpaceGame positionOfSpaceship: 'De Paul') equals: 4
]

{ #category : #tests }
EffectPositionsTests >> testASpaceshipLandsOnAHyperJumpPositionAndAdvancesThirtyParsecs [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          boardWithOnly:
		          { (HyperJumpEffectPosition with: { 30. 20. 10 }) }
		          at: { 2 }
		          Of: 10
		          and: 100.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: { 1 }) }.

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
		          boardWithOnly:
		          { (HyperJumpEffectPosition with: { 3. 20. 10 }) }
		          at: { 2 }
		          Of: 10
		          and: 100.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: { 1 }) }.

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
		          boardWithOnly: { 
				          SpeedUpEffectPosition new.
				          WormHoleEffectPosition new }
		          at: { 2. 6 }
		          Of: 7
		          and: 100.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: { 1 }) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 6
]

{ #category : #tests }
EffectPositionsTests >> testSpaceShipLandsOnAMoonWalkAndMovesBackThreePositionsEveryOtherSpaceShipButItself [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          boardWithOnly: { (MoonWalkEffectPosition withN: 3) }
		          at: { 2 }
		          Of: 5
		          and: 100.
	aDie := LoadedDie rolling: { 1 }.

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
EffectPositionsTests >> testSpaceShipsLandOnHyperJumpPositionFourTimesAndTheLastOneIsAtTheSamePositionAsTheFirstOne [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          boardWithOnly:
		          { (HyperJumpEffectPosition with: { 30. 20. 10 }) }
		          at: { 2 }
		          Of: 10
		          and: 100.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: { 1 }) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul'. 'Paredes'. 'El Dibu' }
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
	self assert: (aSpaceGame positionOfSpaceship: 'El Dibu') equals: 5
]
