Class {
	#name : #DiscreteProbabilityEventSource,
	#superclass : #Object,
	#instVars : [
		'probabilityDistribution',
		'eventsAtIntervals'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiscreteProbabilityEventSource class >> with: aDiscreteProbabilityDistribution [

	^ self new initializeWith: aDiscreteProbabilityDistribution
]

{ #category : #initialization }
DiscreteProbabilityEventSource >> initializeWith: aDiscreteProbabilityDistribution [

	| start end |
	probabilityDistribution := aDiscreteProbabilityDistribution.
	eventsAtIntervals := Dictionary new.
	start := 0.
	end := 0.
	aDiscreteProbabilityDistribution eventProbabilities do: [ :event | 
		start := end.
		end := end + event probability.
		eventsAtIntervals
			at: event
			put: (NumberInterval goingFrom: start to: end) ]
]

{ #category : #accessing }
DiscreteProbabilityEventSource >> next: amountOfItems [

	^ (1 to: amountOfItems) collect: [ :a | self obtainOne ]
]

{ #category : #'as yet unclassified' }
DiscreteProbabilityEventSource >> obtainOne [

	| randomNumber searched |
	randomNumber := Random new next.
	searched := probabilityDistribution eventProbabilities detect: [ :aEvent | 
		         (eventsAtIntervals at: aEvent) contains: randomNumber ].

	^ searched event
]
