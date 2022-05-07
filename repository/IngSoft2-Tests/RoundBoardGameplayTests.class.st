Class {
	#name : #RoundBoardGameplayTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
RoundBoardGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionAndIsInLapOne [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard withPositions: 10.
	aDie := LoadedDie rolling: 10.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame lapsOfSpaceship: 'Messi') equals: 1
]

{ #category : #tests }
RoundBoardGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionAndReturnsToPositionOne [

	| aSpaceGame aBoard aDie lapsToWin |
	lapsToWin := 3.
	aBoard := RoundBoard withPositions: 10.
	aDie := LoadedDie rolling: 10.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie.
		              

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 1
]

{ #category : #tests }
RoundBoardGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionTenTimesAndIsInLapTen [

	| aSpaceGame aBoard aDie |
	aBoard := RoundBoard withPositions: 10.
	aDie := LoadedDie rolling: 104.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie.

	aSpaceGame playNextTurn.

	self assert: (aSpaceGame lapsOfSpaceship: 'Messi') equals: 10
]

{ #category : #tests }
RoundBoardGameplayTests >> testASpaceShipRollsADieAndGoesThroughTheLastPositionThreeTimesAndWins [

	| aSpaceGame aBoard aDie lapsToWin |
	aBoard := RoundBoard withPositions: 10.
	aDie := LoadedDie rolling: 30.
	lapsToWin := 3.

	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aDie
		              with: lapsToWin.

	aSpaceGame playGame.

	self assert: aSpaceGame winner equals: 'Messi'
]
