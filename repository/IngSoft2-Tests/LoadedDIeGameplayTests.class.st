Class {
	#name : #LoadedDieGameplayTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
LoadedDieGameplayTests >> testAGameCannotBeAskedForAWinnerWhenItHasNotFinished [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 3.
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.
	aSpaceGame playNextTurn.

	self
		should: [ aSpaceGame winner ]
		raise: Error
		whoseDescriptionIncludes: 'There is no winner'
		description: 'Nonexistent winner, game in progress'
]

{ #category : #tests }
LoadedDieGameplayTests >> testASpaceShipCannotAdvancePositionWithoutRollingDice [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aDie := LoadedDie rolling: 1.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 5.

	self
		should: [ aSpaceGame advanceCurrentSpaceShipTo: (SpaceShipDistance with: 10 and: 2 on: aBoard)]
		raise: Error
		whoseDescriptionIncludes:
		'Movement cannot be applied before the roll'
		description:
		'A SpaceShip needs to roll the die before moving position'
]

{ #category : #tests }
LoadedDieGameplayTests >> testASpaceShipReachesTheLastPositionAndIsTheWinner [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 10.
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 1.
	aSpaceGame playNextTurn.

	self assert: aSpaceGame winner equals: 'Messi'
]

{ #category : #tests }
LoadedDieGameplayTests >> testASpaceShipRolls14AndEndsUpOnPosition5OfLap2AndGameIsNotFinished [

	| aSpaceGame aBoard aDie |
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
				          NonEffectPosition new }
		          and: 100.
	aDie := LoadedDie rolling: 14.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3.


	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 5.
	self assert: (aSpaceGame lapsOfSpaceship: 'Messi') equals: 2. 
	self deny: aSpaceGame isFinished
]

{ #category : #tests }
LoadedDieGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionAndReturnsToPositionOne [

	| aSpaceGame aBoard aDie |
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
				          NonEffectPosition new }
		          and: 100.
	aDie := LoadedDie rolling: 10.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3.


	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 1.
	self assert: (aSpaceGame lapsOfSpaceship: 'Messi') equals: 2
]

{ #category : #tests }
LoadedDieGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionTenTimesAndIsInLapTen [

	| aSpaceGame aBoard aDie |
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
				          NonEffectPosition new }
		          and: 100.
	aDie := LoadedDie rolling: 104.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 20.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame lapsOfSpaceship: 'Messi') equals: 11
]

{ #category : #tests }
LoadedDieGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionThreeTimesAndWins [

	| aSpaceGame aBoard aDie |
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
				          NonEffectPosition new }
		          and: 100.
	aDie := LoadedDie rolling: 30.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3.

	aSpaceGame playGame.

	self assert: aSpaceGame winner equals: 'Messi'
]

{ #category : #tests }
LoadedDieGameplayTests >> testASpaceShipWinsTheGameAndFinishesInTheRankingFirstPosition [

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
LoadedDieGameplayTests >> testIsPossibleToKnowPositionsOfSpaceshipsAfterGameEnded [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 3.
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul'}
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.
	aSpaceGame playGame.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 1.
	self assert: (aSpaceGame positionOfSpaceship: 'De Paul') equals: 4.
]

{ #category : #tests }
LoadedDieGameplayTests >> testTheGameFinishesWhenASpaceShipGoesThroughTheFinishLine [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 10.
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 1.
	aSpaceGame playNextTurn.

	self assert: aSpaceGame isFinished
]

{ #category : #tests }
LoadedDieGameplayTests >> testTheRankingCanBeCheckedWhileTheGameIsStillInProgress [

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

{ #category : #tests }
LoadedDieGameplayTests >> testThreeSpaceShipPlayTheGameAndTheFirstSpaceShipComesFirstTheSecondSecondAndTheThirdThird [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          SpeedUpEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 50.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: 1) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul'. 'El Dibu' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2.

	aSpaceGame playGame.

	self assert: aSpaceGame ranking first spaceShip equals: 'Messi'.
	self assert: aSpaceGame ranking second spaceShip equals: 'De Paul'.
	self assert: aSpaceGame ranking third spaceShip equals: 'El Dibu'
]

{ #category : #tests }
LoadedDieGameplayTests >> testTwoSpaceShipsPlayTheGameAndTheFirstOneWins [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: 3.
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 1.
	aSpaceGame playGame.

	self assert: aSpaceGame isFinished.
	self assert: aSpaceGame winner equals: 'Messi'
]

{ #category : #tests }
LoadedDieGameplayTests >> testTwoSpaceShipsPlayTheGameWithTwoDiceAndTheGameFinishes [

	| aSpaceGame aBoard aLoadedDie1 aLoadedDie2 aDiceCup |
	aLoadedDie1 := LoadedDie rolling: 3.
	aLoadedDie2 := LoadedDie rolling: 4.
	aDiceCup := DiceCup withAll: { 
			            aLoadedDie1.
			            aLoadedDie2 }.
	aBoard := RoundBoard
		          withPositions: { 
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new.
				          NonEffectPosition new }
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 1.
	aSpaceGame playGame.

	self assert: aSpaceGame isFinished
]
