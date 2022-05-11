Class {
	#name : #RoundBoardGameplayTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
RoundBoardGameplayTests >> testASpaceShipCannotAdvancePositionWithoutRollingDice [

	| aSpaceGame aBoard aDie |
	aBoard := LoadedRoundBoard withPositions: { 
			          NonEffectPosition new.
			          NonEffectPosition new }.
	aDie := LoadedDie rolling: 1.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 5.

	self
		should: [ aSpaceGame advanceCurrentSpaceShipTo: 5 and: 10 ]
		raise: Error
		whoseDescriptionIncludes:
		'Movement cannot be applied before the roll'
		description:
		'A SpaceShip needs to roll the die before moving position'
]

{ #category : #tests }
RoundBoardGameplayTests >> testASpaceShipLandsOnASpeedUpPositionAndAdvances4Spaces [

	| aSpaceGame aBoard aDie |
	aBoard := LoadedRoundBoard withPositions: { 
			          NonEffectPosition new.
			          SpeedUpEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new }.
	aDie := LoadedDie rolling: 1.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 1.
	self deny: aSpaceGame isFinished.
]

{ #category : #tests }
RoundBoardGameplayTests >> testASpaceShipLandsOnAWormHolePositionAndAdvances4Spaces [

	| aSpaceGame aBoard aDie |
	aBoard := LoadedRoundBoard withPositions: { 
			          NonEffectPosition new.
			          WormHoleEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new }.
	aDie := LoadedDie rolling: 1.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 3.
	self assert: (aSpaceGame lapsOfSpaceship: 'Messi') equals: 1.
	self deny: aSpaceGame isFinished.
]

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

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 1.
	self assert: (aSpaceGame lapsOfSpaceship: 'Messi') equals: 2
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
RoundBoardGameplayTests >> testASpaceShipThatLandsOnAMoonWalkTakesEverySpaceShipBackNPositions [

	| aSpaceGame aBoard aDie |
	aBoard := LoadedRoundBoard withPositions: { 
			          NonEffectPosition new.
			          (MoonWalkEffectPosition withN: 3).
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NonEffectPosition new }.
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
RoundBoardGameplayTests >> testASpaceShipThatLandsOnAMoonWalkTakesEverySpaceShipBackToPositionOne [

	| aSpaceGame aBoard aDie |
	aBoard := LoadedRoundBoard withPositions: { 
			          NonEffectPosition new.
			          NonEffectPosition new.
			          NukeEffectPosition new.
			          NonEffectPosition new }.
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
	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 1.

]

{ #category : #tests }
RoundBoardGameplayTests >> testTwoSpaceShipsPlayTheGameWithARandomRoundBoardAndTheGameFinishes [

	| aSpaceGame aBoard aDie |
	aBoard := RandomRoundBoard with: 100.
	aDie := RandomDie withSides: 6.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'De Paul' }
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 5.

	aSpaceGame playGame .
	
	self assert: aSpaceGame isFinished.

]
