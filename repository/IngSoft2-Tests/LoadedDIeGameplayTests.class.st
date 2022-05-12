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
		              playedBy: { 'Messi'. 'De Paul' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.
	aSpaceGame playGame.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 1.
	self assert: (aSpaceGame positionOfSpaceship: 'De Paul') equals: 4
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
