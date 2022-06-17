Class {
	#name : #CardTests,
	#superclass : #MessirveTests,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTests >> testASpaceShipBeginsTheGameWithTwoCards [

	| aSpaceGame aLoadedDie aBoard |
	aLoadedDie := LoadedDie rolling: { 5 }.
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { OverloadCard new }.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi') size
		equals: 2
]

{ #category : #tests }
CardTests >> testASpaceShipCannotPlayACancellationCardOnAnotherCancellationCard [

	| aSpaceGame aLoadedDie aBoard cancellationCardOne cancellationCardTwo speedCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	cancellationCardOne := CancellationCard new.
	cancellationCardTwo := CancellationCard new.
	speedCard := SpeedCard new.
	aBoard := RoundBoard
		          boardWithOnly:
		          { (CardDealerEffect handing: cancellationCardTwo) }
		          at: { 3 }
		          Of: 5
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { 
				              cancellationCardOne.
				              speedCard }.

	aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi'.
	aSpaceGame playNextTurn.

	self
		should: [ 
			aSpaceGame
				spaceShip: 'Messi'
				plays: cancellationCardTwo
				on: cancellationCardOne ]
		raise: Error
		whoseDescriptionIncludes:
		'The targeted card is not currently active'
		description: 'Invalid target chosen'
]

{ #category : #tests }
CardTests >> testASpaceShipCannotPlayAPermanentCardWhenItsNotTheirTurn [

	| aSpaceGame aLoadedDie aBoard speedCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	speedCard := SpeedCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { speedCard }.

	self
		should: [ 
		aSpaceGame spaceShip: 'Armani' plays: speedCard on: 'Messi' ]
		raise: Error
		whoseDescriptionIncludes:
		'Permanent cards can only be played during the turn of a Spaceship'
		description:
		'A permanent card is being played during a different turn of the playing spaceship'
]

{ #category : #tests }
CardTests >> testASpaceShipCannotPlayARedoCardOnASpeedCardDuringATurnThatIsNotTheirs [

	| aSpaceGame aLoadedDie aBoard redoCard speedCard |
	aLoadedDie := LoadedDie rolling: { 6 }.
	redoCard := RedoCard new.
	speedCard := SpeedCard new.
	aBoard := RoundBoard
		          boardWithOnly: { SpeedUpEffect new }
		          at: { 2 }
		          Of: 5
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 5
		              handing: { 
				              speedCard.
				              speedCard.
				              redoCard.
				              redoCard }.

	aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi'.

	self
		should: [ 
		aSpaceGame spaceShip: 'Armani' plays: redoCard on: 'Messi' ]
		raise: Error
		whoseDescriptionIncludes:
		'Permanent cards can only be played during the turn of a Spaceship'
		description:
		'A permanent card is being played during a different turn of the playing spaceship'
]

{ #category : #tests }
CardTests >> testASpaceShipCannotPlayARepeatCardWhenThereAreNoLastEffectsApplied [

	| aSpaceGame aLoadedDie aBoard repeatCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	repeatCard := RepeatCard new.
	aBoard := RoundBoard
		          boardWithOnly: { SpeedUpEffect new }
		          at: { 2 }
		          Of: 5
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 5
		              handing: { 
				              repeatCard.
				              repeatCard }.
	self
		should: [ 
		aSpaceGame spaceShip: 'Messi' plays: repeatCard on: 'Messi' ]
		raise: Error
		whoseDescriptionIncludes: 'There was no effect previously played'
		description: 'There was no effect previously played'
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
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { overloadCard }.
	aSpaceGame playNextTurn.

	self assert: (aSpaceGame inventoryFrom: 'Messi') equals: { 
			overloadCard.
			overloadCard.
			speedCard } asOrderedCollection
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
				          (CardDealerEffect handing: speedCard) }
		          at: { 2. 3 }
		          Of: 5
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { overloadCard }.
	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.

	self assert: (aSpaceGame inventoryFrom: 'Messi') equals: { 
			overloadCard.
			overloadCard.
			speedCard.
			speedCard } asOrderedCollection
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
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { overloadCard }.
	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 6
		with: 1
		in: aSpaceGame.

	self assert: (aSpaceGame inventoryFrom: 'Messi') equals: { 
			overloadCard.
			overloadCard } asOrderedCollection
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysACancellationCardOnTheActiveAccelerationCardAndMovesOneTileAhead [

	| aSpaceGame aLoadedDie aBoard accelerationCard cancellationCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	accelerationCard := AccelerationCard new.
	cancellationCard := CancellationCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { 
				              accelerationCard.
				              cancellationCard }.

	aSpaceGame spaceShip: 'Messi' plays: accelerationCard on: 'Messi'.
	aSpaceGame
		spaceShip: 'Messi'
		plays: cancellationCard
		on: accelerationCard.
	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 2
		with: 1
		in: aSpaceGame
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysACancellationCardOnTheActiveSpeedUpEffectAndTheEngineIsNoLongerPowered [

	| aSpaceGame aLoadedDie aBoard speedCard cancellationCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	speedCard := SpeedCard new.
	cancellationCard := CancellationCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { 
				              speedCard.
				              cancellationCard }.

	aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi'.

	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 3
		with: 1
		in: aSpaceGame.

	aSpaceGame spaceShip: 'Messi' plays: cancellationCard on: speedCard.
	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 4
		with: 1
		in: aSpaceGame
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysACancellationCardOnTheSpeedCardOfAnotherPlayerAndAdvancesOneLessSpaceNextTurn [

	| aSpaceGame aLoadedDie aBoard speedCardOne speedCardTwo cancellationCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	speedCardOne := SpeedCard new.
	speedCardTwo := SpeedCard new.
	cancellationCard := CancellationCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { 
				              speedCardOne.
				              speedCardTwo.
				              cancellationCard.
				              cancellationCard }.

	aSpaceGame spaceShip: 'Messi' plays: speedCardOne on: 'Messi'.

	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 3
		with: 1
		in: aSpaceGame.

	aSpaceGame
		spaceShip: 'Armani'
		plays: cancellationCard
		on: speedCardOne.
	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.
	self
		assert: 'Messi'
		isAt: 4
		with: 1
		in: aSpaceGame
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
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { overloadCard }.

	self
		should: [ 
		aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi' ]
		raise: Error
		whoseDescriptionIncludes: 'SpaceShip doesnt own that card'
		description: 'SpaceShip doesnt own that card'
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysARedoCardAfterACancellationWasPlayedAndTheRedoCardCancelsAnActiveAccelerationCard [

	| aSpaceGame aLoadedDie aBoard accelerationCardM accelerationCardA redoCard cancellationCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	accelerationCardM := AccelerationCard new.
	accelerationCardA := AccelerationCard new.
	redoCard := RedoCard new.
	cancellationCard := CancellationCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { 
				              accelerationCardM.
				              accelerationCardA.
				              redoCard.
				              cancellationCard }.

	aSpaceGame spaceShip: 'Messi' plays: accelerationCardM on: aSpaceGame.
	aSpaceGame playNextTurn.

	aSpaceGame
		spaceShip: 'Armani'
		plays: accelerationCardA
		on: aSpaceGame.
	aSpaceGame
		spaceShip: 'Armani'
		plays: cancellationCard
		on: accelerationCardM.
	aSpaceGame playNextTurn.

	aSpaceGame spaceShip: 'Messi' plays: redoCard on: accelerationCardA.

	self assert: (aSpaceGame inventoryFrom: 'Messi') isEmpty.
	self assert: (aSpaceGame inventoryFrom: 'Armani') isEmpty.
	self assert: (aSpaceGame activeCardsFrom: 'Messi') isEmpty.
	self assert: (aSpaceGame activeCardsFrom: 'Armani')  isEmpty
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysARedoCardAfterACancellationWasPlayedAndTheRedoCardCancelsAnActiveOverloadCard [

	| aSpaceGame aLoadedDie aBoard overLoadCardM overLoadCardA redoCard cancellationCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	overLoadCardM := OverloadCard new.
	overLoadCardA := OverloadCard new.
	redoCard := RedoCard new.
	cancellationCard := CancellationCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { 
				              overLoadCardM.
				              overLoadCardA.
				              redoCard.
				              cancellationCard }.

	aSpaceGame spaceShip: 'Messi' plays: overLoadCardM on: 'Messi'.
	aSpaceGame playNextTurn.

	aSpaceGame spaceShip: 'Armani' plays: overLoadCardA on: 'Armani'.
	aSpaceGame
		spaceShip: 'Armani'
		plays: cancellationCard
		on: overLoadCardM.
	aSpaceGame playNextTurn.

	aSpaceGame spaceShip: 'Messi' plays: redoCard on: overLoadCardA.

	self assert: (aSpaceGame inventoryFrom: 'Messi') isEmpty.
	self assert: (aSpaceGame inventoryFrom: 'Armani') isEmpty.
	self assert: (aSpaceGame activeCardsFrom: 'Messi') isEmpty.
	self assert: (aSpaceGame activeCardsFrom: 'Armani') isEmpty
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysARedoCardAfterACancellationWasPlayedAndTheRedoCardCancelsAnActiveSpeedCard [

	| aSpaceGame aLoadedDie aBoard speedCardM speedCardA redoCard cancellationCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	speedCardM := SpeedCard new.
	speedCardA := SpeedCard new.
	redoCard := RedoCard new.
	cancellationCard := CancellationCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { 
				              speedCardM.
				              speedCardA.
				              redoCard.
				              cancellationCard }.

	aSpaceGame spaceShip: 'Messi' plays: speedCardM on: 'Messi'.
	aSpaceGame playNextTurn.

	aSpaceGame spaceShip: 'Armani' plays: speedCardA on: 'Armani'.
	aSpaceGame spaceShip: 'Armani' plays: cancellationCard on: speedCardM.
	aSpaceGame playNextTurn.

	aSpaceGame spaceShip: 'Messi' plays: redoCard on: speedCardA.

	self assert: (aSpaceGame inventoryFrom: 'Messi') isEmpty.
	self assert: (aSpaceGame inventoryFrom: 'Armani') isEmpty.
	self assert: (aSpaceGame activeCardsFrom: 'Messi') isEmpty.
	self assert: (aSpaceGame activeCardsFrom: 'Armani') isEmpty
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysARedoCardAfterACancellationWasUsedOnASpeedAndTheRedoCancellsTheLastSpeed [

	| aSpaceGame aLoadedDie aBoard speedCard1 speedCard2 redoCard cancellationCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	speedCard1 := SpeedCard new.
	speedCard2 := SpeedCard new.
	redoCard := RedoCard new.
	cancellationCard := CancellationCard new.
	aBoard := RoundBoard
		          boardWithOnly: { 
				          (CardDealerEffect handing: redoCard).
				          (CardDealerEffect handing: cancellationCard) }
		          at: { 2. 3 }
		          Of: 5
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 3
		              handing: { 
				              speedCard1.
				              speedCard2 }.

	aSpaceGame playNextTurn.
	aSpaceGame playNextTurn.


	self assert: (aSpaceGame inventoryFrom: 'Messi') equals: { 
			speedCard1.
			speedCard2.
			redoCard.
			cancellationCard } asOrderedCollection.

	aSpaceGame spaceShip: 'Messi' plays: speedCard1 on: 'Messi'.
	aSpaceGame spaceShip: 'Messi' plays: speedCard2 on: 'Messi'.
	aSpaceGame spaceShip: 'Messi' plays: cancellationCard on: speedCard1.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi')
		equals: { redoCard } asOrderedCollection.
	self
		assert: (aSpaceGame activeCardsFrom: 'Messi')
		equals: { speedCard2 } asOrderedCollection.

	aSpaceGame spaceShip: 'Messi' plays: redoCard on: speedCard2.

	self
		assert: aSpaceGame cardApplicator lastCardPlayed
		equals: cancellationCard.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi') isEmpty.
		
		self
		assert: (aSpaceGame activeCardsFrom: 'Messi') isEmpty.
	
	aSpaceGame playNextTurn.
	self
		assert: 'Messi'
		isAt: 4
		with: 1
		in: aSpaceGame
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysARedoCardAfterARedoCardAndStillAppliesTheSpeedCardFirstlyPlayed [

	| aSpaceGame aLoadedDie aBoard speedCard redoCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	speedCard := SpeedCard new.
	redoCard := RedoCard new.
	aBoard := RoundBoard
		          boardWithOnly: { (CardDealerEffect handing: redoCard) }
		          at: { 2 }
		          Of: 5
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 3
		              handing: { 
				              speedCard.
				              redoCard }.

	aSpaceGame playNextTurn.
	
	aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi'.
	aSpaceGame spaceShip: 'Messi' plays: redoCard on: 'Messi'.
	aSpaceGame spaceShip: 'Messi' plays: redoCard on: 'Messi'.
	
		
	self assert: (aSpaceGame activeCardsFrom: 'Messi')	equals: { speedCard . speedCard . speedCard } asOrderedCollection.
	
	self assert: aSpaceGame cardApplicator lastCardPlayed equals: speedCard.
	
	aSpaceGame playNextTurn.
	    self
        assert: 'Messi'
        isAt: 1
        with: 2
        in: aSpaceGame
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysARedoCardAfterASpeedCardWasPlayedAndTheSpeedEffectIsTriggeredTwiceToAdvanceToPositionFour [

	| aSpaceGame aLoadedDie aBoard speedCard redoCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	speedCard := SpeedCard new.
	redoCard := RedoCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { 
				              speedCard.
				              redoCard }.

	aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi'.
	aSpaceGame spaceShip: 'Messi' plays: redoCard on: 'Messi'.
	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 4
		with: 1
		in: aSpaceGame
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysARedoCardAfterAnOverloadCardWasPlayedAndTheOverloadEffectIsTriggeredTwiceToGoBackToPositionOne [

	| aSpaceGame aLoadedDie aBoard overloadCard redoCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	overloadCard := OverloadCard new.
	redoCard := RedoCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { 
				              overloadCard.
				              redoCard }.
	aSpaceGame playNextTurn.
	aSpaceGame spaceShip: 'Messi' plays: overloadCard on: 'Messi'.
	aSpaceGame spaceShip: 'Messi' plays: redoCard on: 'Messi'.
	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 1
		with: 1
		in: aSpaceGame
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysARedoCardButIsNotSavedAsLastCardPlayed [

	| aSpaceGame aLoadedDie aBoard speedCard redoCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	speedCard := SpeedCard new.
	redoCard := RedoCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { 
				              speedCard.
				              redoCard }.

	aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi'.
	aSpaceGame spaceShip: 'Messi' plays: redoCard on: 'Messi'.
	aSpaceGame playNextTurn.

	self assert: aSpaceGame cardApplicator lastCardPlayed equals: speedCard
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysARedoCardThreeTimesAfterAnOverloadCardWasPlayedAndNextTurnGoesBackOneLap [

	| aSpaceGame aLoadedDie aBoard overloadCard redoCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	overloadCard := OverloadCard new.
	redoCard := RedoCard new.
	aBoard := RoundBoard
		          boardWithOnly: { 
				          (CardDealerEffect handing: redoCard).
				          (CardDealerEffect handing: redoCard) }
		          at: { 2. 3 }
		          Of: 5
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 3
		              handing: { 
				              overloadCard.
				              redoCard }.

	1 to: 5 do: [ :i | aSpaceGame playNextTurn ].

	aSpaceGame spaceShip: 'Messi' plays: overloadCard on: 'Messi'.
	aSpaceGame spaceShip: 'Messi' plays: redoCard on: 'Messi'.
	aSpaceGame spaceShip: 'Messi' plays: redoCard on: 'Messi'.
	aSpaceGame spaceShip: 'Messi' plays: redoCard on: 'Messi'.


	self assert: (aSpaceGame inventoryFrom: 'Messi') isEmpty.
	self assert: (aSpaceGame activeCardsFrom: 'Messi') equals: { 
			overloadCard.
			overloadCard.
			overloadCard.
			overloadCard } asOrderedCollection.

	self
		assert: 'Messi'
		isAt: 1
		with: 2
		in: aSpaceGame.

	aSpaceGame playNextTurn.
	self
		assert: 'Messi'
		isAt: 1
		with: 1
		in: aSpaceGame
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysARepeatCardAndAdvancesFourTilesBecauseASpeedUpWasThePreviousEffect [

	| aSpaceGame aLoadedDie aBoard repeatCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	repeatCard := RepeatCard new.
	aBoard := RoundBoard
		          boardWithOnly: { SpeedUpEffect new }
		          at: { 2 }
		          Of: 5
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 5
		              handing: { 
				              repeatCard.
				              repeatCard }.

	aSpaceGame playNextTurn.
	aSpaceGame spaceShip: 'Messi' plays: repeatCard on: 'Messi'.
	
	self
		assert: 'Messi'
		isAt: 5
		with: 2
		in: aSpaceGame.

]

{ #category : #tests }
CardTests >> testASpaceShipPlaysASpeedCardOnAnotherSpaceShipAndTheOtherSpaceShipAdvancesOneExtraSpacePerTurn [

	| aSpaceGame aLoadedDie aBoard speedCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	speedCard := SpeedCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { speedCard }.

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
		in: aSpaceGame
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysASpeedCardOnItselfAndAdvancesAnExtraPositionEveryTurn [

	| aSpaceGame aLoadedDie aBoard speedCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	speedCard := SpeedCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { speedCard }.

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
		in: aSpaceGame
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysASpeedCardOnItselfTwiceAndAdvancesThreePositions [

	| aSpaceGame aLoadedDie aBoard speedCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	speedCard := SpeedCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { speedCard }.

	aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi'.
	aSpaceGame spaceShip: 'Messi' plays: speedCard on: 'Messi'.

	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 4
		with: 1
		in: aSpaceGame
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysAnOverloadCardOnAnotherOneAndTheCardGoesToActiveCardsOfTheOtherSpaceShip [

	| aSpaceGame aLoadedDie aBoard overloadCard speedCard |
	aLoadedDie := LoadedDie rolling: { 5 }.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { 
				              overloadCard.
				              speedCard }.

	aSpaceGame spaceShip: 'Messi' plays: overloadCard on: 'Armani'.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi')
		equals: { overloadCard } asOrderedCollection.

	self assert: (aSpaceGame inventoryFrom: 'Armani') equals: { 
			speedCard.
			speedCard } asOrderedCollection.

	self assert: (aSpaceGame activeCardsFrom: 'Messi') isEmpty.

	self
		assert: (aSpaceGame activeCardsFrom: 'Armani')
		equals: { overloadCard } asOrderedCollection
]

{ #category : #tests }
CardTests >> testASpaceShipPlaysAnOverloadCardOnAnotherSpaceShipAndItDoesntMoveAfterRollingOne [

	| aSpaceGame aLoadedDie aBoard overloadCard speedCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { 
				              overloadCard.
				              speedCard }.

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
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { 
				              overloadCard.
				              speedCard }.

	aSpaceGame spaceShip: 'Messi' plays: overloadCard on: 'Messi'.

	self assert: (aSpaceGame inventoryFrom: 'Messi') size equals: 1.

	self
		assert: (aSpaceGame inventoryFrom: 'Messi')
		equals: { speedCard } asOrderedCollection.

	self
		assert: (aSpaceGame activeCardsFrom: 'Messi')
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
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { speedCard }.

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
CardTests >> testASpaceShipUsesARepeatCardAfterAnotherSpaceShipLandedOnASpeedEffect [

	| aSpaceGame aLoadedDie aBoard repeatCard |
	aLoadedDie := LoadedDie rolling: { 6 }.
	repeatCard := RepeatCard new.
	aBoard := RoundBoard
		          boardWithOnly: { SpeedUpEffect new }
		          at: { 2 }
		          Of: 5
		          and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'Paredes'. 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 5
		              handing: { repeatCard }.
	
	aSpaceGame playNextTurn.
	self assert: 'Messi' isAt: 1 with: 3 in: aSpaceGame.
	aSpaceGame spaceShip: 'Armani' plays: repeatCard on: 'Armani'.
	self assert: 'Armani' isAt: 5 with: 1 in: aSpaceGame.
	aSpaceGame spaceShip: 'Paredes' plays: repeatCard on: 'Armani'.
	self assert: 'Armani' isAt: 4 with: 2 in: aSpaceGame.
]

{ #category : #tests }
CardTests >> testASpaceShipUsesAnAccelerationAndAfterPlayingNextTurnAdvancesToNextLap [

	| aSpaceGame aLoadedDie aBoard accelerationCard |
	aLoadedDie := LoadedDie rolling: { 4 }.
	accelerationCard := AccelerationCard new.
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 5
		              handing: { accelerationCard }.

	aSpaceGame spaceShip: 'Messi' plays: accelerationCard on: aSpaceGame.

	aSpaceGame playNextTurn.

	self
		assert: 'Messi'
		isAt: 1
		with: 2
		in: aSpaceGame
]

{ #category : #tests }
CardTests >> testASpaceShipUsesAnAccelerationAndIncreasesEnginePowerOfAllSpaceShipsInOne [

	| aSpaceGame aLoadedDie aBoard accelerationCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	accelerationCard := AccelerationCard new.
	aBoard := RoundBoard withNoEffectsOf: 10 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { accelerationCard }.

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
		in: aSpaceGame
]

{ #category : #tests }
CardTests >> testAllPlayingSpaceShipsPlayOverloadCardOnItselfTwiceAndAfterNextTurnGoesBackOneLap [

	| aSpaceGame aLoadedDie aBoard overloadCard |
	aLoadedDie := LoadedDie rolling: { 1 }.
	overloadCard := OverloadCard new.
	aBoard := RoundBoard withNoEffectsOf: 3 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 3
		              handing: { overloadCard }.

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
		isAt: 1
		with: 1
		in: aSpaceGame
]

{ #category : #tests }
CardTests >> testSixSpaceShipsBeginTheGameWithOverloadAndSpeedCards [

	| aSpaceGame aLoadedDie aBoard speedCard overloadCard |
	aLoadedDie := LoadedDie rolling: { 5 }.
	speedCard := SpeedCard new.
	overloadCard := OverloadCard new.
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy:
		              { 'Messi'. 'Armani'. 'De Paul'. 'Di Maria'. 'Lo Celso'.
		              'Paredes' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { 
				              overloadCard.
				              speedCard.
				              overloadCard }.
	aSpaceGame playNextTurn.

	self assert: (aSpaceGame inventoryFrom: 'Messi') equals: { 
			overloadCard.
			overloadCard } asOrderedCollection.

	self assert: (aSpaceGame inventoryFrom: 'Armani') equals: { 
			speedCard.
			speedCard } asOrderedCollection.
	self assert: (aSpaceGame inventoryFrom: 'De Paul') equals: { 
			overloadCard.
			overloadCard } asOrderedCollection.
	self assert: (aSpaceGame inventoryFrom: 'Di Maria') equals: { 
			overloadCard.
			overloadCard } asOrderedCollection.
	self assert: (aSpaceGame inventoryFrom: 'Lo Celso') equals: { 
			speedCard.
			speedCard } asOrderedCollection.
	self assert: (aSpaceGame inventoryFrom: 'Paredes') equals: { 
			overloadCard.
			overloadCard } asOrderedCollection
]

{ #category : #tests }
CardTests >> testTwoSpaceShipsBeginTheGameWithOverloadAndSpeedCards [

	| aSpaceGame aLoadedDie aBoard speedCard overloadCard |
	aLoadedDie := LoadedDie rolling: { 5 }.
	speedCard := SpeedCard new.
	overloadCard := OverloadCard new.
	aBoard := RoundBoard withNoEffectsOf: 5 and: 100.
	aSpaceGame := MessirveSpaceRaceGame
		              playedBy: { 'Messi'. 'Armani' }
		              on: aBoard
		              rolling: aLoadedDie
		              withLapsToWin: 2
		              handing: { 
				              overloadCard.
				              speedCard.
				              speedCard.
				              overloadCard }.
	aSpaceGame playNextTurn.

	self assert: (aSpaceGame inventoryFrom: 'Messi') equals: { 
			overloadCard.
			speedCard } asOrderedCollection.

	self assert: (aSpaceGame inventoryFrom: 'Armani') equals: { 
			speedCard.
			overloadCard } asOrderedCollection
]
