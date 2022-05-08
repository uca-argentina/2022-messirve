Class {
	#name : #RoundBoardGameplayTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
RoundBoardGameplayTests >> testASpaceShipRolls14AndEndsUpOnPosition5OfLap2AndGameIsNotFinished [

	| aSpaceGame aBoard aDie |
	aBoard := LoadedRoundBoard withPositions: { 
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new }.
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
RoundBoardGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionAndIsInLapTwo [

	| aSpaceGame aBoard aDie |
	aBoard := LoadedRoundBoard withPositions: { 
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new }.
	aDie := LoadedDie rolling: 10.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame lapsOfSpaceship: 'Messi') equals: 2
]

{ #category : #tests }
RoundBoardGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionAndReturnsToPositionOne [

	| aSpaceGame aBoard aDie |
	aBoard := LoadedRoundBoard withPositions: { 
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new }.
	aDie := LoadedDie rolling: 10.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3.


	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 1
]

{ #category : #tests }
RoundBoardGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionTenTimesAndIsInLapTen [

	| aSpaceGame aBoard aDie |
	aBoard := LoadedRoundBoard withPositions: { 
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new }.
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
RoundBoardGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionThreeTimesAndWins [

	| aSpaceGame aBoard aDie |
	aBoard := LoadedRoundBoard withPositions: { 
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new }.
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
RoundBoardGameplayTests >> testASpaceShipRollsADieAndLandsOnANonEffectPositionAndItsPositionDoesntChange [

	| aSpaceGame aBoard aDie |
	aBoard := LoadedRoundBoard withPositions: {NonEffectPosition new . NonEffectPosition new . NonEffectPosition new . NonEffectPosition new . NonEffectPosition new}.
	aDie := LoadedDie rolling: 1.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 2. 

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 2
]
