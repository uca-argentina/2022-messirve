Class {
	#name : #CardTests,
	#superclass : #MessirveTests,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTests >> testASpaceShipBeginsTheGameWithTwoCards [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: { 5 }.
	aBoard := RoundBoard
		          withNoEffectsOf: 5
		          and: 100
		          handing: { OverloadCard new }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.
	aSpaceGame playNextTurn.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi') inventory size
		equals: 2
]

{ #category : #tests }
CardTests >> testASpaceShipLandsOnAPositionHandingASpeedCardAndNowHasThreeCards [

	| aSpaceGame aLoadedDie aBoard overloadCard speedCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	aBoard := RoundBoard
		          boardWithOnly: { (CardDealerEffect handing: speedCard) }
		          at: { 2 }
		          Of: 5
		          and: 100
		          handing: { overloadCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.
	aSpaceGame playNextTurn.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi') inventory
		equals: { 
				overloadCard.
				overloadCard.
				speedCard } asOrderedCollection.
]

{ #category : #tests }
CardTests >> testASpaceShipLandsOnAPositionHandingASpeedCardTwiceAndNowHasFourCards [

	| aSpaceGame aLoadedDie aBoard overloadCard speedCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	aBoard := RoundBoard
		          boardWithOnly: { 
				          (CardDealerEffect handing: speedCard).
				          (CardDealerEffect handing: overloadCard) }
		          at: { 2. 3 }
		          Of: 5
		          and: 100
		          handing: { overloadCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.
	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi') inventory
		equals: { 
				overloadCard.
				overloadCard.
				speedCard.
				overloadCard } asOrderedCollection
]

{ #category : #tests }
CardTests >> testASpaceShipLandsOnASpeedUpAndAdvancesToAPositionHandingSpeedCardButDoesntReceiveTheSpeedCard [

	| aSpaceGame aLoadedDie aBoard overloadCard speedCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	aBoard := RoundBoard
		          boardWithOnly: { 
				          SpeedUpEffect new.
				          (CardDealerEffect handing: speedCard) }
		          at: { 2. 6 }
		          Of: 10
		          and: 100
		          handing: { overloadCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.
	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 6
		with: 1
		in: aSpaceGame.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi') inventory
		equals: { 
				overloadCard.
				overloadCard } asOrderedCollection
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysACardThatDoesntOwnAndAnErrorExceptionIsRaised [

	| aSpaceGame aLoadedDie aBoard overloadCard speedCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	aBoard := RoundBoard
		          boardWithOnly: { 
				          SpeedUpEffect new.
				          (CardDealerEffect handing: speedCard) }
		          at: { 2. 6 }
		          Of: 10
		          and: 100
		          handing: { overloadCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.

	self
		should: [ 
		aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi' ]
		raise: Error
		whoseDescriptionIncludes: 'SpaceShip doesnt own that card'
		description: 'SpaceShip doesnt own that card'
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysASpeedCardOnAnotherSpaceShipAndTheOtherSpaceShipAdvancesOneExtraSpacePerTurn [

	| aSpaceGame aLoadedDie aBoard speedCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	speedCard := SpeedCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100 handing: { 
			          speedCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' . 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.

	aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Armani'.
	
	aSpaceGame playNextTurn.
	
	self
		assert: 'Messi'
		isAt: 2
		with: 1
		in: aSpaceGame.
		
	aSpaceGame playNextTurn.
	
	self
		assert: 'Armani'
		isAt: 3
		with: 1
		in: aSpaceGame.
	
	
	

]

{ #category : #tests }
CardTests >> testASpaceShipPlaysASpeedCardOnItselfAndAdvancesAnExtraPositionEveryTurn [

	| aSpaceGame aLoadedDie aBoard speedCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	speedCard := SpeedCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100 handing: { 
			          speedCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.

	aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi'.
	aSpaceGame playNextTurn.
	
	self
		assert: 'Messi'
		isAt: 3
		with: 1
		in: aSpaceGame.
		
		aSpaceGame playNextTurn.
	
	self
		assert: 'Messi'
		isAt: 5
		with: 1
		in: aSpaceGame.
	
	
	

]

{ #category : #tests }
CardTests >> testASpaceShipPlaysASpeedCardOnItselfTwiceAndAdvancesThreePositions [

	| aSpaceGame aLoadedDie aBoard speedCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	speedCard := SpeedCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100 handing: { 
			          speedCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.

	aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi'.
	aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi'.

	aSpaceGame playNextTurn.
	
	self
		assert: 'Messi'
		isAt: 4
		with: 1
		in: aSpaceGame.

	
	
	

]

{ #category : #tests }
CardTests >> testASpaceShipPlaysAnOverloadCardOnAnotherOneAndTheCardGoesToActiveCardsOfTheOtherSpaceShip [

	| aSpaceGame aLoadedDie aBoard overloadCard speedCard |
	aLoadedDie := LoadedDie rolling: { 5 }.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100 handing: { 
			          overloadCard.
			          speedCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.

	aSpaceGame spaceShip: 'Messi' plays: overloadCard on: 'Armani'.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi') inventory
		equals: { overloadCard } asOrderedCollection.

	self
		assert: (aSpaceGame inventoryFrom: 'Armani') inventory
		equals: { 
				speedCard.
				speedCard } asOrderedCollection.

	self assert: (aSpaceGame inventoryFrom: 'Messi') activeCards isEmpty.

	self
		assert: (aSpaceGame inventoryFrom: 'Armani') activeCards
		equals: { overloadCard } asOrderedCollection.
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysAnOverloadCardOnAnotherOneAndTheOtherSpaceShipDoesntMoveAfterRollingOne [

	| aSpaceGame aLoadedDie aBoard overloadCard speedCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100 handing: { 
			          overloadCard.
			          speedCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.

	aSpaceGame spaceShip: 'Messi' plays: overloadCard on: 'Armani'.
	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 2
		with: 1
		in: aSpaceGame.

	self
		assert: 'Armani'
		isAt: 1
		with: 1
		in: aSpaceGame
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysAnOverloadCardOnItselfAndHasOnlyOneCardLeft [

	| aSpaceGame aLoadedDie aBoard overloadCard speedCard |
	aLoadedDie := LoadedDie rolling: { 5 }.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100 handing: { 
			          overloadCard.
			          speedCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.

	aSpaceGame spaceShip: 'Messi' plays: overloadCard on: 'Messi'.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi') inventory size
		equals: 1.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi') inventory
		equals: { speedCard } asOrderedCollection.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi') activeCards
		equals: { overloadCard } asOrderedCollection
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysTwoSpeedCardsOnItSelfPlaysTheTurnReceivesASpeedCardPlaysTheNewlyReceivedSpeedCardPlaysTheNextTurnAndAdvancesOneLap [

	| aSpaceGame aLoadedDie aBoard speedCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	speedCard := SpeedCard new.
	aBoard := RoundBoard
		          boardWithOnly: { (CardDealerEffect handing: speedCard) }
		          at: { 4 }
		          Of: 7
		          and: 100
		          handing: { speedCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.

	aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi'.
	aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi'.

	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 4
		with: 1
		in: aSpaceGame.

	aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi'.
	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 1
		with: 2
		in: aSpaceGame
]

{ #category : #tests }
CardTests >> testASpaceShipUsesAnAccelerationAndAfterPlayingNextTurnAdvancesToNextLap [

	| aSpaceGame aLoadedDie aBoard accelerationCard |
	aLoadedDie := LoadedDie rolling: { 4 }.
	accelerationCard := AccelerationCard new.
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100 handing: { 
			          accelerationCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 5.

	aSpaceGame spaceShip: 'Messi' plays: accelerationCard on: aSpaceGame.

	aSpaceGame playNextTurn.
	
	self
		assert: 'Messi'
		isAt: 1
		with: 2
		in: aSpaceGame.
	
	
	

]

{ #category : #tests }
CardTests >> testASpaceShipUsesAnAccelerationAndIncreasesEnginePowerOfAllSpaceShipsInOne [

	| aSpaceGame aLoadedDie aBoard accelerationCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	accelerationCard := AccelerationCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100 handing: { 
			          accelerationCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' . 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.

	aSpaceGame spaceShip: 'Messi' plays: accelerationCard on: aSpaceGame.

	aSpaceGame playNextTurn.
	
	self
		assert: 'Messi'
		isAt: 3
		with: 1
		in: aSpaceGame.
		
	aSpaceGame playNextTurn.
	
	self
		assert: 'Armani'
		isAt: 3
		with: 1
		in: aSpaceGame.
	
	
	

]

{ #category : #tests }
CardTests >> testAllPlayingSpaceShipsPlayOverloadCardOnItselfTwiceAndAfterNextTurnGoesBackOneLap [

	| aSpaceGame aLoadedDie aBoard overloadCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	overloadCard := OverloadCard new.
	aBoard := RoundBoard
		          withNoEffectsOf: 3
		          and: 100
		          handing: { overloadCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 3.

	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 1
		with: 2
		in: aSpaceGame.
		
	aSpaceGame spaceShip: 'Messi' plays: overloadCard on: 'Messi'.
	aSpaceGame spaceShip: 'Messi' plays: overloadCard on: 'Messi'.

	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 3
		with: 1
		in: aSpaceGame.
	

]

{ #category : #tests }
CardTests >> testSixSpaceShipsBeginTheGameWithOverloadAndSpeedCards [

	| aSpaceGame aLoadedDie aBoard speedCard overloadCard |
	aLoadedDie := LoadedDie rolling: { 5 }.
	speedCard := SpeedCard new.
	overloadCard := OverloadCard new.
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100 handing: { 
			          overloadCard.
			          speedCard.
			          overloadCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy:
		              { 'Messi'. 'Armani'. 'De Paul'. 'Di Maria'. 'Lo Celso'.
		              'Paredes' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.
	aSpaceGame playNextTurn.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi') inventory
		equals: { 
				overloadCard.
				overloadCard } asOrderedCollection.

	self
		assert: (aSpaceGame inventoryFrom: 'Armani') inventory
		equals: { 
				speedCard.
				speedCard } asOrderedCollection.
	self
		assert: (aSpaceGame inventoryFrom: 'De Paul') inventory
		equals: { 
				overloadCard.
				overloadCard } asOrderedCollection.
	self
		assert: (aSpaceGame inventoryFrom: 'Di Maria') inventory
		equals: { 
				overloadCard.
				overloadCard } asOrderedCollection.
	self
		assert: (aSpaceGame inventoryFrom: 'Lo Celso') inventory
		equals: { 
				speedCard.
				speedCard } asOrderedCollection.
	self
		assert: (aSpaceGame inventoryFrom: 'Paredes') inventory
		equals: { 
				overloadCard.
				overloadCard } asOrderedCollection
]

{ #category : #tests }
CardTests >> testTwoSpaceShipsBeginTheGameWithOverloadAndSpeedCards [

	| aSpaceGame aLoadedDie aBoard speedCard overloadCard |
	aLoadedDie := LoadedDie rolling: { 5 }.
	speedCard := SpeedCard new.
	overloadCard := OverloadCard new.
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100 handing: { 
			          overloadCard.
			          speedCard.
			          speedCard.
			          overloadCard }.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2.
	aSpaceGame playNextTurn.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi') inventory
		equals: { 
				overloadCard.
				speedCard } asOrderedCollection.

	self
		assert: (aSpaceGame inventoryFrom: 'Armani') inventory
		equals: { 
				speedCard.
				overloadCard } asOrderedCollection
]
