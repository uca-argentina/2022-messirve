Class {
	#name : #ObjectCreationTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ObjectCreationTests >> test002ADieCannotHaveLessThanThreeSides [

	self
		should: [ RandomDie withSides: -1 ]
		raise: Error
		whoseDescriptionIncludes: 'A die cannot have less than three sides'
		description: 'Die sides must be >= 3'
]

{ #category : #tests }
ObjectCreationTests >> test004ABoardCannotBeCreatedWithLessThanTwoPositions [

	self
		should: [ StraightBoard withPositions: 0 ]
		raise: Error
		whoseDescriptionIncludes:
		'A board cannot have less than two positions'
		description: 'Board positions must be >1'
]

{ #category : #tests }
ObjectCreationTests >> test011TwoSpaceshipsWithTheSameNameCannotBeAddedToGame [

	| aSpaceGame aBoard aDiceCup |
	aBoard := StraightBoard withPositions: 10.
	aDiceCup := DiceCup withAll: {  }.

	self
		should: [ 
			aSpaceGame := MessirveSpaceRaceGame
				              playedBy: { 'Messi'. 'Messi' }
				              on: aBoard
				              rolling: aDiceCup ]
		raise: Error
		whoseDescriptionIncludes: 'Player name duplicated'
		description:
		'Two players with the same name cannot be added to game'
]

{ #category : #tests }
ObjectCreationTests >> testASpaceShipBeginsInPositionOne [

	| aSpaceGame aBoard |
	aBoard := StraightBoard withPositions: 10.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: ''.

	self assert: (aSpaceGame positionOfSpaceship: 'Messi') equals: 1
]
