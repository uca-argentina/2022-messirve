Class {
	#name : #RoundBoardGameplayTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
RoundBoardGameplayTests >> testASpaceShipCannotAdvancePositionWithoutRollingDice [

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
RoundBoardGameplayTests >> testASpaceShipRolls14AndEndsUpOnPosition5OfLap2AndGameIsNotFinished [

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
RoundBoardGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionAndReturnsToPositionOne [

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
RoundBoardGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionTenTimesAndIsInLapTen [

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
RoundBoardGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionThreeTimesAndWins [

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
RoundBoardGameplayTests >> testTwoSpaceShipsPlayTheGameWithARandomRoundBoardAndTheGameFinishes [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard with: 200 and: 100.
	aDie := RandomDie withSides: 6. 

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' . 'De Paul' } 
		              on: aBoard
		              rolling: aDie
		              withLapsToWin: 3.

	aSpaceGame playGame .
	
	self assert: aSpaceGame isFinished.

]
