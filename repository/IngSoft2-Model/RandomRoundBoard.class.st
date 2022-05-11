Class {
	#name : #RandomRoundBoard,
	#superclass : #Object,
	#instVars : [
		'positions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomRoundBoard class >> with: positions [ 
	^self new initializeWith: positions .
]

{ #category : #initialization }
RandomRoundBoard >> initializeWith: aNumberOfPositions [ 
	
	| boardPositions |
	positions := aNumberOfPositions.
	boardPositions := OrderedCollection new.
	
	1 to: 40 do: [: i | boardPositions add: NonEffectPosition new ].
	1 to: 20 do: [: i | boardPositions add: NonEffectPosition new ].
	1 to: 20 do: [: i | boardPositions add: NonEffectPosition new ].
	1 to: 10 do: [: i | boardPositions add: (MoonWalkEffectPosition  withN: (1 to: 10) atRandom) ].
	1 to: 10 do: [: i | boardPositions add: NonEffectPosition new ].
	boardPositions shuffle.
	
	
	
	
	
	
	
]
