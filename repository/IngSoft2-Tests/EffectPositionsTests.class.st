Class {
	#name : 'EffectPositionsTests',
	#superclass : 'MessirveTests',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectPositionsTests >> testASpaceShipLandsOnAPositionWithoutEffectAndTheLapAndPositionAreNotModified [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: { 5 }.
	aBoard := RoundBoard withNoEffectsOf: 10 with: 100 and: 0.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { SpeedCard new }.

	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 6
		with: 1
		in: aSpaceGame
]

{ #category : 'tests' }
EffectPositionsTests >> testASpaceShipLandsOnASpeedUpAndThusFinishesLapOneAndIsNowOnLapTwo [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          boardWithOnly: { SpeedUpEffect new }
		          at: { 2 }
		          Of: 5
		          with: 100 and: 0.
	aDie := LoadedDie rolling: { 1. 4 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3
		              handing: { SpeedCard new }.

	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 1
		with: 2
		in: aSpaceGame.

	self deny: aSpaceGame isFinished
]

{ #category : 'tests' }
EffectPositionsTests >> testASpaceShipLandsOnASpeedUpPositionAndAdvancesFourSpaces [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          boardWithOnly: { SpeedUpEffect new }
		          at: { 2 }
		          Of: 10
		          with: 100 and: 0.
	aDie := LoadedDie rolling: { 1. 4 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3
		              handing: { SpeedCard new }.

	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 6
		with: 1
		in: aSpaceGame.

	self deny: aSpaceGame isFinished
]

{ #category : 'tests' }
EffectPositionsTests >> testASpaceShipLandsOnAWormHolePositionAndCannotGoBackBehindTheStartingPoint [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          boardWithOnly: { WormHoleEffect new }
		          at: { 2 }
		          Of: 5
		          with: 100 and: 0.
	aDie := LoadedDie rolling: { 1 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3
		              handing: { SpeedCard new }.

	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 1
		with: 1
		in: aSpaceGame.
	self deny: aSpaceGame isFinished
]

{ #category : 'tests' }
EffectPositionsTests >> testASpaceShipLandsOnAWormHolePositionAndGoesBackFourSpaces [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          boardWithOnly: { WormHoleEffect new }
		          at: { 2 }
		          Of: 5
		          with: 100 and: 0.
	aDie := LoadedDie rolling: { 6 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3
		              handing: { SpeedCard new }.

	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 3
		with: 1
		in: aSpaceGame.
	self deny: aSpaceGame isFinished
]

{ #category : 'tests' }
EffectPositionsTests >> testASpaceShipThatLandsOnAnAtomicBombAfterFinishingTheFirstLapTakesEverySpaceShipBackToPositionOneButMaintainsItsAchievedLaps [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          boardWithOnly: { AtomicBombEffect new }
		          at: { 1 }
		          Of: 3
		          with: 100 and: 0.
	aDie := LoadedDie rolling: { 1. 1. 1. 2 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'De Paul'. 'Armani'. 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 5
		              handing: { SpeedCard new }.

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

{ #category : 'tests' }
EffectPositionsTests >> testASpaceShipThatLandsOnAnAtomicBombTakesEverySpaceShipBackToPositionOne [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          boardWithOnly: { AtomicBombEffect new }
		          at: { 3 }
		          Of: 4
		          with: 100 and: 0.
	aDie := LoadedDie rolling: { 1 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul'. 'Armani' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 5
		              handing: { SpeedCard new }.

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

{ #category : 'tests' }
EffectPositionsTests >> testASpaceshipLandsOnAHyperJumpPositionAfterAnotherSpaceshipAndAdvancesTwentyParsecs [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          boardWithOnly:
		          { (HyperJumpEffect with: { 30. 20. 10 } and: { 0. 0. 0 }) }
		          at: { 2 }
		          Of: 10
		          with: 100
		          and: 0.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: { 1 }) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2
		              handing: { SpeedCard new }.

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

{ #category : 'tests' }
EffectPositionsTests >> testASpaceshipLandsOnAHyperJumpPositionAfterAnotherSpaceshipAndAdvancesTwentyParsecsButLightyearsAreNotZero [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          boardWithOnly:
		          { (HyperJumpEffect with: { 25. 15. 5 } and: { 15. 15. 15 }) }
		          at: { 2 }
		          Of: 10
		          with: 100
		          and: 0.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: { 1 }) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2
		              handing: { SpeedCard new }.

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

{ #category : 'tests' }
EffectPositionsTests >> testASpaceshipLandsOnAHyperJumpPositionAndAdvancesThirtyParsecs [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          boardWithOnly:
		          { (HyperJumpEffect with: { 30. 20. 10 } and: { 0. 0. 0 }) }
		          at: { 2 }
		          Of: 10
		          with: 100
		          and: 0.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: { 1 }) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2
		              handing: { SpeedCard new }.

	aSpaceGame playNextTurn.


	self
		assert: 'Messi'
		isAt: 5
		with: 1
		in: aSpaceGame
]

{ #category : 'tests' }
EffectPositionsTests >> testASpaceshipLandsOnAHyperJumpPositionButTheParsecsAwardedAreNotEnoughToMove [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          boardWithOnly:
		          { (HyperJumpEffect with: { 7 } and: { 0 }) }
		          at: { 2 }
		          Of: 10
		          with: 100
		          and: 0.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: { 1 }) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2
		              handing: { SpeedCard new }.

	aSpaceGame playNextTurn.


	self
		assert: 'Messi'
		isAt: 2
		with: 1
		in: aSpaceGame
]

{ #category : 'tests' }
EffectPositionsTests >> testASpaceshipLandsOnAHyperJumpPositionThatMovesItForwardFivePositionsAndAdvancesOneLap [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          boardWithOnly:
		          { (HyperJumpEffect with: { 10 } and: { 0 }) }
		          at: { 10 }
		          Of: 10
		          with: 100
		          and: 0.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: { 9 }) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 5
		              handing: { SpeedCard new }.

	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 1
		with: 2
		in: aSpaceGame
]

{ #category : 'tests' }
EffectPositionsTests >> testASpaceshipThatMovesForwardFourAfterLandingOnASpeedUpDoesNotGoBackFourAfterLandingOnAWormHoleOnTheSameTurn [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          boardWithOnly: { 
				          SpeedUpEffect new.
				          WormHoleEffect new }
		          at: { 2. 6 }
		          Of: 7
		          with: 100 and: 0.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: { 1 }) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2
		              handing: { SpeedCard new }.

	aSpaceGame playNextTurn.


	self
		assert: 'Messi'
		isAt: 6
		with: 1
		in: aSpaceGame
]

{ #category : 'tests' }
EffectPositionsTests >> testSpaceShipLandsOnACardDealerEffectPositionAndReceivesOneCard [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          boardWithOnly: { (CardDealerEffect handingRandomCards) }
		          at: { 2 }
		          Of: 10
		          with: 100 and: 0.
	aDie := LoadedDie rolling: { 1 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul'. 'Armani' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 5
		              handing: { SpeedCard new }.

	aSpaceGame playNextTurn.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi') size
		equals: 3
]

{ #category : 'tests' }
EffectPositionsTests >> testSpaceShipLandsOnAMoonWalkAndMovesBackThreePositionsEveryOtherSpaceShipButItself [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          boardWithOnly: { (MoonWalkEffect takingBack: 1) }
		          at: { 3 }
		          Of: 5
		          with: 100 and: 0.
	aDie := LoadedDie rolling: { 1 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul'. 'Armani' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 5
		              handing: { SpeedCard new }.

	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.
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
		isAt: 3
		with: 1
		in: aSpaceGame
]

{ #category : 'tests' }
EffectPositionsTests >> testSpaceShipLandsOnAMoonWalkAndMovesEveryOtherSpaceShipOneLapBehind [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          boardWithOnly: { (MoonWalkEffect takingBack: 3) }
		          at: { 2 }
		          Of: 10
		          with: 100 and: 0.
	aDie := LoadedDie rolling: { 10. 10. 10. 1 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul'. 'Armani' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 5
		              handing: { SpeedCard new }.

	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 1
		with: 2
		in: aSpaceGame.
	self
		assert: 'De Paul'
		isAt: 1
		with: 2
		in: aSpaceGame.
	self
		assert: 'Armani'
		isAt: 1
		with: 2
		in: aSpaceGame.

	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 2
		with: 2
		in: aSpaceGame.
	self
		assert: 'De Paul'
		isAt: 8
		with: 1
		in: aSpaceGame.
	self
		assert: 'Armani'
		isAt: 8
		with: 1
		in: aSpaceGame
]

{ #category : 'tests' }
EffectPositionsTests >> testSpaceShipsLandOnHyperJumpPositionFourTimesAndTheLastOneIsAtTheSamePositionAsTheFirstOne [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          boardWithOnly:
		          { (HyperJumpEffect with: { 30. 20. 10 } and: { 0. 0. 0 }) }
		          at: { 2 }
		          Of: 10
		          with: 100
		          and: 0.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: { 1 }) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul'. 'Paredes'. 'El Dibu' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2
		              handing: { SpeedCard new }.

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
