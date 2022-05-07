Class {
	#name : #ObjectCreationTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ObjectCreationTests >> testADieCannotHaveLessThanThreeSides [

	self
		should: [ RandomDie withSides: -1 ]
		raise: Error
		whoseDescriptionIncludes: 'A die cannot have less than three sides'
		description: 'Die sides must be >= 3'
]

{ #category : #tests }
ObjectCreationTests >> testARoundBoardCannotBeCreatedWithLessThanTwoPositions [

	self
		should: [ RoundBoard withPositions: 0 ]
		raise: Error
		whoseDescriptionIncludes:
		'A round board cannot have less than two positions'
		description: 'Board positions must be >1'
]

{ #category : #tests }
ObjectCreationTests >> testASpaceShipBeginsInPositionOne [

	| aSpaceGame aBoard |
	aBoard := StraightBoard withPositions: 10.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: ''
		              withLapsToWin: 1.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 1
]

{ #category : #tests }
ObjectCreationTests >> testAStraightBoardCannotBeCreatedWithLessThanTwoPositions [

	self
		should: [ StraightBoard withPositions: 0 ]
		raise: Error
		whoseDescriptionIncludes:
		'A straight board cannot have less than two positions'
		description: 'Board positions must be >1'
]

{ #category : #tests }
ObjectCreationTests >> testTwoSpaceshipsWithTheSameNameCannotBeAddedToGame [

	| aSpaceGame aBoard aDiceCup |
	aBoard := StraightBoard withPositions: 10.
	aDiceCup := DiceCup withAll: { '' }.

	self
		should: [ 
			aSpaceGame := MessirveSpaceRaceGame
				              playedBy: { 'Messi'. 'Messi' }
				              on: aBoard
				              rolling: aDiceCup
				              withLapsToWin: 1 ]
		raise: Error
		whoseDescriptionIncludes: 'Player name duplicated'
		description:
		'Two players with the same name cannot be added to game'
]
