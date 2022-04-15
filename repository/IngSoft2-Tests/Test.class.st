Class {
	#name : #Test,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
Test >> test001ADieWithSixSidesHasSixSides [
	|aDie|
	aDie := Die withSides: 6.
	self assert: (aDie sides) equals: 6.
]

{ #category : #tests }
Test >> test002ADieCannotHaveLessThanThreeSides [

	self
		should: [ Die withSides: -1 ]
		raise: Error
		whoseDescriptionIncludes: 'A die cannot have less than three sides'
		description: 'Die sides must be >= 3'
]

{ #category : #tests }
Test >> test003ABoardWithThreePositionsHasThreePositions [
	|aBoard|
	aBoard := Board withPositions: 3.
	self assert: (aBoard positions) equals: 3.
]

{ #category : #tests }
Test >> test004ABoardCannotBeCreatedWithLessThanTwoPositions [

	self
		should: [ Board withPositions: 0 ]
		raise: Error
		whoseDescriptionIncludes:
		'A board cannot have less than two positions'
		description: 'Board positions must be >1'
]

{ #category : #tests }
Test >> test005ADiceCupWithOneDieHasOneDie [

	|aDiceCup aDie|
	aDie := Die withSides: 7.
	aDiceCup := DiceCup initializeWithDice: { aDie } .
	self assert: (aDiceCup dice) size equals: 1.

]

{ #category : #tests }
Test >> test006ADiceCupWithThreeDiceHasThreeDice [

	|aDiceCup aDie1 aDie2 aDie3|
	
	aDie1 := Die withSides: 7.
	aDie2 := Die withSides: 5.
	aDie3 := Die withSides: 4.
	aDiceCup := DiceCup initializeWithDice: { aDie1 . aDie2 . aDie3} .
	
	self assert: ((aDiceCup dice) size) equals: 3.
]

{ #category : #tests }
Test >> test007ADiceCupWithADieAlwaysRollsANumberBetweenOneAndTheNumberOfSides [

	|aDiceCup aDie numberOfSides |
	
	numberOfSides := 6.
	aDie := Die withSides: numberOfSides.
	aDiceCup := DiceCup initializeWithDice: { aDie } .
		
	self assert: ((aDiceCup roll) between: 1 and: numberOfSides).

]

{ #category : #tests }
Test >> test008ASpaceshipInitializedWithNameMessiHasNameMessi [

	|aSpaceShip|
	
	aSpaceShip := SpaceShip withName: 'Messi'.
	
	self assert: aSpaceShip name equals: 'Messi'
]

{ #category : #tests }
Test >> test009AGameInitializedWithTwoSpaceshipHasTwoSpaceship [

	|aSpaceGame aBoard aDiceCup |
	
	aBoard := Board withPositions: 10.
	aDiceCup := DiceCup initializeWithDice: { } . 
	
	aSpaceGame := SpaceGame withBoard: aBoard diceCup: aDiceCup andSpaceShips: { 'Messi' . 'De Paul' }. 
	
	

	
	self assert: aSpaceGame spaceShipStatuses size equals: 2.
]

{ #category : #tests }
Test >> test010ASpaceShipIsNotLongerInTheSamePositionAfterRollingADiceCup [

	|aSpaceGame aBoard aDiceCup aDie initialPositionOfSpaceship finalPositionOfSpaceship |
	
	aBoard := Board withPositions: 10.
	aDie := Die withSides: 5.
	aDiceCup := DiceCup initializeWithDice: { aDie } .
	
	aSpaceGame := SpaceGame withBoard: aBoard diceCup: aDiceCup  andSpaceShips: { 'Messi' } .
	
	initialPositionOfSpaceship := aSpaceGame positionOfSpaceship: 'Messi'.
	aSpaceGame playTurnOfSpaceship: 'Messi'.
	finalPositionOfSpaceship := aSpaceGame positionOfSpaceship: 'Messi'.
	
	self deny: initialPositionOfSpaceship equals: finalPositionOfSpaceship.
]
