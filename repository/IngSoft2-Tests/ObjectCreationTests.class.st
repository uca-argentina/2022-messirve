Class {
	#name : #ObjectCreationTests,
	#superclass : #MessirveTests,
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
		should: [ RoundBoard withPositions: {  } and: 100 ]
		raise: Error
		whoseDescriptionIncludes:
		'A board cannot have less than two positions'
		description: 'Board positions must be >1'
]

{ #category : #tests }
ObjectCreationTests >> testASpaceShipBeginsInPositionOne [

	| aSpaceGame aBoard |
	aBoard := RoundBoard with: 100 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: ''
		              withLapsToWin: 1.

		self
		assert: 'Messi'
		isAt: 1
		with: 1
		in: aSpaceGame
]

{ #category : #tests }
ObjectCreationTests >> testTwoSpaceshipsWithTheSameNameCannotBeAddedToGame [

	| aSpaceGame aBoard aDiceCup |
	aBoard := RoundBoard with: 100 and: 100.
	aDiceCup := DiceCup withAll: { '' }.

	self
		should: [ 
			aSpaceGame := MessirveSpaceRaceGame
				              playedBy: { 'Messi'. 'Messi' }
				              on: aBoard
				              rolling: aDiceCup
				              withLapsToWin: 1 ]
		raise: Error
		whoseDescriptionIncludes: 'SpaceShip name duplicated'
		description:
		'Two SpaceShip with the same name cannot be added to game'
]
