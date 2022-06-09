Class {
	#name : #LoadedDieGameplayTests,
	#superclass : #MessirveTests,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
LoadedDieGameplayTests >> testAGameCannotBeAskedForAWinnerWhenItHasNotFinished [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: { 3 }.
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100.
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
LoadedDieGameplayTests >> testASpaceShipReachesTheLastPositionAndIsTheWinner [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: { 5 }.
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.
	aSpaceGame playNextTurn.

	self assert: aSpaceGame winner equals: 'Messi'
]

{ #category : #tests }
LoadedDieGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionAndReturnsToPositionOne [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aDie := LoadedDie rolling: { 10 }.

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
		in: aSpaceGame
]

{ #category : #tests }
LoadedDieGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionTenTimesAndIsInLapTen [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aDie := LoadedDie rolling: { 104 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 20.

	aSpaceGame playNextTurn.

		self
		assert: 'Messi'
		isAt: 5
		with: 11
		in: aSpaceGame
]

{ #category : #tests }
LoadedDieGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionThreeTimesAndWins [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aDie := LoadedDie rolling: { 30 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3.

	aSpaceGame playGame.

	self assert: aSpaceGame winner equals: 'Messi'
]

{ #category : #tests }
LoadedDieGameplayTests >> testASpaceShipRollsFourteenAndEndsUpOnPositionFiveOfLapTwoAndGameIsNotFinished [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aDie := LoadedDie rolling: { 14 }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3.


	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 5
		with: 2
		in: aSpaceGame.
	self deny: aSpaceGame isFinished
]

{ #category : #tests }
LoadedDieGameplayTests >> testASpaceShipRollsOneHundredButCannotGetFurtherOnTheBoardThanTheFirstPositionOfTheWinningLap [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: { 100 }.
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 5.
	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 1
		with: 5
		in: aSpaceGame
]

{ #category : #tests }
LoadedDieGameplayTests >> testASpaceShipWinsTheGameAndFinishesInTheRankingFirstPosition [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard withNoEffectsOf: 5 and: 50.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: { 1. 2. 1. 2. 1. 1 }) }.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 2.

	aSpaceGame playGame.
	aSpaceGame calculateNewRanking.
	self assert: aSpaceGame ranking first spaceShip equals: 'De Paul'
]

{ #category : #tests }
LoadedDieGameplayTests >> testIsPossibleToKnowPositionsOfSpaceshipsAfterGameEnded [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: { 3 }.
	aBoard := RoundBoard withNoEffectsOf: 6 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul'}
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.
	aSpaceGame playGame.

		self
		assert: 'Messi'
		isAt: 1
		with: 2
		in: aSpaceGame.
		self
		assert: 'De Paul'
		isAt: 4
		with: 1
		in: aSpaceGame
]

{ #category : #tests }
LoadedDieGameplayTests >> testTheGameFinishesWhenASpaceShipGoesThroughTheFinishLine [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: { 10 }.
	aBoard := RoundBoard withNoEffectsOf: 6 and: 100.
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
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100.
	aDiceCup := DiceCup withAll: {LoadedDie rolling: { 1 }}.

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
LoadedDieGameplayTests >> testThreeSpaceShipPlayTheGameAndMessiComesFirstDePaulSecondAndElDibuThird [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard withNoEffectsOf: 5 and: 50.
	aDiceCup := DiceCup withAll: { (LoadedDie rolling: { 3. 2. 1}) }.

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
LoadedDieGameplayTests >> testTwoSpaceShipsPlayTheGameAndMessiComesFirst [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: { 3 }.
	aBoard := RoundBoard withNoEffectsOf: 6 and: 100.
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
	aLoadedDie1 := LoadedDie rolling: { 3 }.
	aLoadedDie2 := LoadedDie rolling: { 4 }.
	aDiceCup := DiceCup withAll: { 
			            aLoadedDie1.
			            aLoadedDie2 }.
	aBoard := RoundBoard withNoEffectsOf: 6 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul' }
		              on: aBoard
		              rolling: aDiceCup
		              withLapsToWin: 1.
	aSpaceGame playGame.

	self assert: aSpaceGame isFinished
]
