Class {
	#name : #DiceCupTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceCupTests >> testADiceCupCannotBeEmpty [
	| aDiceCup |
	
	self
		should: [ aDiceCup := DiceCup withAll: { }. ]
		raise: Error
		whoseDescriptionIncludes:
		'A dice cup cannot be empty'
		description:
		'A dice cup must contain at least one die'
]

{ #category : #tests }
DiceCupTests >> testADiceCupWithADieRollsANumberBetweenOneAndTheNumberOfSides [

	| aDiceCup aDie numberOfSides |
	numberOfSides := 6.
	aDie := RandomDie withSides: numberOfSides.
	aDiceCup := DiceCup withAll: { aDie }.

	self assert: (aDiceCup roll between: 1 and: numberOfSides)
]

{ #category : #tests }
DiceCupTests >> testDiceCupRollsTheSumOfTheRollsOfEachDieInside [

	| aDiceCup aLoadedDie aLoadedDie2 aLoadedDie3 |
	aLoadedDie := LoadedDie rolling: { 4 }.
	aLoadedDie2 := LoadedDie rolling: { 3 }.
	aLoadedDie3 := LoadedDie rolling: { 8 }.
	aDiceCup := DiceCup withAll: { 
			            aLoadedDie.
			            aLoadedDie2.
			            aLoadedDie3 }.

	self assert: aDiceCup roll equals: 15
]
