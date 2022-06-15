Class {
	#name : #DiscreteProbabilityEventSource,
	#superclass : #Object,
	#instVars : [
		'probabilityDistribution'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiscreteProbabilityEventSource class >> with: aDiscreteProbabilityDistribution [

	^ self new initializeWith: aDiscreteProbabilityDistribution
]

{ #category : #initialization }
DiscreteProbabilityEventSource >> initializeWith: aDiscreteProbabilityDistribution [

	probabilityDistribution := aDiscreteProbabilityDistribution
]

{ #category : #accessing }
DiscreteProbabilityEventSource >> next: amountOfItems [

	^ (1 to: amountOfItems) collect: [ :a | self obtainOne ]
]

{ #category : #'as yet unclassified' }
DiscreteProbabilityEventSource >> obtainOne [
	
	^probabilityDistribution associatedLinealDistribution atRandom.
]
