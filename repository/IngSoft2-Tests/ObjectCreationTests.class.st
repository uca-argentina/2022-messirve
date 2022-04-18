Class {
	#name : #ObjectCreationTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ObjectCreationTests >> test001ADieWithSixSidesHasSixSides [
	|aDie|
	aDie := Die withSides: 6.
	self assert: (aDie sides) equals: 6.
]

{ #category : #tests }
ObjectCreationTests >> test002ADieCannotHaveLessThanThreeSides [

	self
		should: [ Die withSides: -1 ]
		raise: Error
		whoseDescriptionIncludes: 'A die cannot have less than three sides'
		description: 'Die sides must be >= 3'
]

{ #category : #tests }
ObjectCreationTests >> test003ABoardWithThreePositionsHasThreePositions [

	| aBoard |
	aBoard := StraightBoard withPositions: 3.
	self assert: aBoard positions equals: 3
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
ObjectCreationTests >> test005ADiceCupWithOneDieHasOneDie [

	| aDiceCup aDie |
	aDie := Die withSides: 7.
	aDiceCup := DiceCup initializeWithDice: { aDie }.
	self assert: aDiceCup dice size equals: 1
]

{ #category : #tests }
ObjectCreationTests >> test006ADiceCupWithThreeDiceHasThreeDice [

	| aDiceCup aDie1 aDie2 aDie3 |
	aDie1 := Die withSides: 7.
	aDie2 := Die withSides: 5.
	aDie3 := Die withSides: 4.
	aDiceCup := DiceCup initializeWithDice: { 
			            aDie1.
			            aDie2.
			            aDie3 }.

	self assert: aDiceCup dice size equals: 3
]

{ #category : #tests }
ObjectCreationTests >> test007ADiceCupWithADieRollsANumberBetweenOneAndTheNumberOfSides [

	| aDiceCup aDie numberOfSides |
	numberOfSides := 6.
	aDie := Die withSides: numberOfSides.
	aDiceCup := DiceCup initializeWithDice: { aDie }.

	self assert: (aDiceCup roll between: 1 and: numberOfSides)
]

{ #category : #tests }
ObjectCreationTests >> test008ASpaceshipInitializedWithNameMessiHasNameMessi [

	| aSpaceShip |
	aSpaceShip := SpaceShip withName: 'Messi'.

	self assert: aSpaceShip name equals: 'Messi'
]

{ #category : #tests }
ObjectCreationTests >> test009AGameInitializedWithTwoSpaceshipHasTwoSpaceship [

	| aSpaceGame aBoard aDiceCup |
	aBoard := StraightBoard withPositions: 10.
	aDiceCup := DiceCup initializeWithDice: {  }.

	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aDiceCup
		              andSpaceShips: { 'Messi'. 'De Paul' }.




	self assert: aSpaceGame spaceShipStatuses size equals: 2
]

{ #category : #tests }
ObjectCreationTests >> test010ASpaceShipIsNotLongerInTheSamePositionAfterRollingADiceCup [

	| aSpaceGame aBoard aDiceCup aDie initialPositionOfSpaceship finalPositionOfSpaceship |
	aBoard := StraightBoard withPositions: 10.
	aDie := Die withSides: 5.
	aDiceCup := DiceCup initializeWithDice: { aDie }.

	aSpaceGame := SpaceGame
		              withBoard: aBoard
		              diceCup: aDiceCup
		              andSpaceShips: { 'Messi' }.

	initialPositionOfSpaceship := aSpaceGame positionOfSpaceship: 'Messi'.
	aSpaceGame playTurnOfSpaceship: 'Messi'.
	finalPositionOfSpaceship := aSpaceGame positionOfSpaceship: 'Messi'.

	self
		deny: initialPositionOfSpaceship
		equals: finalPositionOfSpaceship
]

{ #category : #tests }
ObjectCreationTests >> test011TwoSpaceshipsWithTheSameNameCannotBeAddedToGame [

	| aSpaceGame aBoard aDiceCup |
	aBoard := StraightBoard withPositions: 10.
	aDiceCup := DiceCup initializeWithDice: {  }.

	self
		should: [ 
			aSpaceGame := SpaceGame
				              withBoard: aBoard
				              diceCup: aDiceCup
				              andSpaceShips: { 'Messi'. 'Messi' } ]
		raise: Error
		whoseDescriptionIncludes: 'Player name duplicated'
		description:
		'Two players with the same name cannot be added to game'
]

{ #category : #tests }
ObjectCreationTests >> test012ALoadedDieRollsTheLoadedResult [

	| aLoadedDie aLoadedDieResult |
	aLoadedDie := LoadedDie rolling: 4.
	aLoadedDieResult := aLoadedDie roll.

	self assert: aLoadedDieResult equals: 4
]

{ #category : #tests }
ObjectCreationTests >> test013ADiceCupWithThreeLoadedDiceRollsTheLoadedResults [

	| aDiceCup aLoadedDie aLoadedDie2 aLoadedDie3 |
	aLoadedDie := LoadedDie rolling: 4.
	aLoadedDie2 := LoadedDie rolling: 3.
	aLoadedDie3 := LoadedDie rolling: 8.
	aDiceCup := DiceCup initializeWithDice: { 
			            aLoadedDie.
			            aLoadedDie2.
			            aLoadedDie3 }.

	self assert: aDiceCup roll equals: 15
]
