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
