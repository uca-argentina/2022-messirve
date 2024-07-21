"
Represents a probability distribution with discrete outcomes, used for random events in the game.
"
Class {
	#name : 'DiscreteProbabilityDistribution',
	#superclass : 'Object',
	#instVars : [
		'eventProbabilities'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'asserting' }
DiscreteProbabilityDistribution class >> assertCorrectSumOf: eventProbabilities [

	(eventProbabilities sum: [ :event | event probability ]) = 1 
		ifFalse: [ Error signal: 'The sum of probabilities must be 1' ]
]

{ #category : 'instance creation' }
DiscreteProbabilityDistribution class >> withAll: eventProbabilities [

	self assertCorrectSumOf: eventProbabilities.
	^ self new initializeWithAll: eventProbabilities
]

{ #category : 'accessing' }
DiscreteProbabilityDistribution >> eventProbabilities [

	^ eventProbabilities
]

{ #category : 'initialization' }
DiscreteProbabilityDistribution >> initializeWithAll: someEventProbabilities [

	eventProbabilities := someEventProbabilities
]
