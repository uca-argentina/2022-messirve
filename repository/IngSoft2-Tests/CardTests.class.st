Class {
	#name : #CardTests,
	#superclass : #MessirveTests,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTests >> testAPlayerBeginsTheGameWithTwoCards [

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
CardTests >> testTwoPlayersBeginTheGameWithOverloadAndSpeedCards [

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
