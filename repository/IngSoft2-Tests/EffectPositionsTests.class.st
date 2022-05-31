Class {
	#name : #EffectPositionsTests,
	#superclass : #MessirveTests,
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
	aDie := LoadedDie rolling: { 1. 4 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3.

	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 1
		with: 2
		in: aSpaceGame.

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

	self
		assert: 'Messi'
		isAt: 1
		with: 1
		in: aSpaceGame.
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

	self
		assert: 'De Paul'
		isAt: 2
		with: 1
		in: aSpaceGame.
	self
		assert: 'Armani'
		isAt: 2
		with: 1
		in: aSpaceGame.
	self
		assert: 'Messi'
		isAt: 2
		with: 1
		in: aSpaceGame.

	aSpaceGame playNextTurn.

	self
		assert: 'De Paul'
		isAt: 1
		with: 2
		in: aSpaceGame.
	self
		assert: 'Armani'
		isAt: 1
		with: 1
		in: aSpaceGame.
	self
		assert: 'Messi'
		isAt: 1
		with: 1
		in: aSpaceGame
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

	self
		assert: 'De Paul'
		isAt: 2
		with: 1
		in: aSpaceGame.

	self
		assert: 'Armani'
		isAt: 2
		with: 1
		in: aSpaceGame.

	self
		assert: 'Messi'
		isAt: 2
		with: 1
		in: aSpaceGame.

	aSpaceGame playNextTurn.

	self
		assert: 'De Paul'
		isAt: 1
		with: 1
		in: aSpaceGame.

	self
		assert: 'Armani'
		isAt: 1
		with: 1
		in: aSpaceGame.

	self
		assert: 'Messi'
		isAt: 1
		with: 1
		in: aSpaceGame
]

{ #category : #tests }
EffectPositionsTests >> testASpaceshipLandsOnAHyperJumpPositionAfterAnotherSpaceshipAndAdvancesTwentyParsecs [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          boardWithOnly:
		          { (HyperJumpEffectPosition with: { 30. 20. 10 }) }
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

	self
		assert: 'Messi'
		isAt: 5
		with: 1
		in: aSpaceGame.

	aSpaceGame playNextTurn.

	self
		assert: 'De Paul'
		isAt: 4
		with: 1
		in: aSpaceGame
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


	self
		assert: 'Messi'
		isAt: 5
		with: 1
		in: aSpaceGame
]

{ #category : #tests }
EffectPositionsTests >> testASpaceshipLandsOnAHyperJumpPositionButTheParsecsAwardedAreNotEnoughToMove [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          boardWithOnly: { (HyperJumpEffectPosition with: { 3 }) }
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


	self
		assert: 'Messi'
		isAt: 2
		with: 1
		in: aSpaceGame
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


	self
		assert: 'Messi'
		isAt: 6
		with: 1
		in: aSpaceGame
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


	self
		assert: 'De Paul'
		isAt: 4
		with: 1
		in: aSpaceGame.
	self
		assert: 'Armani'
		isAt: 4
		with: 1
		in: aSpaceGame.
	self
		assert: 'Messi'
		isAt: 2
		with: 1
		in: aSpaceGame
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


	self
		assert: 'Messi'
		isAt: 5
		with: 1
		in: aSpaceGame.

	self
		assert: 'De Paul'
		isAt: 4
		with: 1
		in: aSpaceGame.

	self
		assert: 'Paredes'
		isAt: 3
		with: 1
		in: aSpaceGame.

	self
		assert: 'Messi'
		isAt: 5
		with: 1
		in: aSpaceGame
]
