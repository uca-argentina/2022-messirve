Class {
	#name : 'MessirveTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'accessing' }
MessirveTests >> assert: spaceshipName isAt: aPosition with: aLap in: aMessirveSpaceRaceGame [

	self
		assert: (aMessirveSpaceRaceGame positionOfSpaceship: spaceshipName)
		equals: aPosition.
	self
		assert: (aMessirveSpaceRaceGame lapsOfSpaceship: spaceshipName)
		equals: aLap
]
