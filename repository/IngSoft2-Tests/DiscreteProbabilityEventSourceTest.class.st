Class {
	#name : #DiscreteProbabilityEventSourceTest,
	#superclass : #TestCase,
	#instVars : [
		'soruce'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DiscreteProbabilityEventSourceTest >> assert: events are: anEvent [
	self shouldBeImplemented.
]

{ #category : #tests }
DiscreteProbabilityEventSourceTest >> testSourceProvidesColorsRedTenTimesWhenEventDistributionHasNoProbabilityForColorBlue [

	| events red discreteProbabilityDistribution source redProbabilityEvent blue blueProbabilityEvent |
	red := Color red.
	blue := Color blue.
	redProbabilityEvent := ProbabilityEvent of: red with: 1.
	blueProbabilityEvent := ProbabilityEvent of: blue with: 0.

	discreteProbabilityDistribution := DiscreteProbabilityDistribution withAll: {redProbabilityEvent. blueProbabilityEvent}.
	source := DiscreteProbabilityEventSource with: discreteProbabilityDistribution.
	
	events := source next: 10000.
	
	self assertAllIn: events are: red.
	self assertNoneIn: events are: blue
]

{ #category : #tests }
DiscreteProbabilityEventSourceTest >> testSourceProvidesTenTimesTheSameEventForASingleEventDistribution [

	| effects speedUpEffect discreteProbabilityDistribution source speedUpProbabilityEvent |
	speedUpEffect := SpeedUpEffect new.
	speedUpProbabilityEvent := ProbabilityEvent of: speedUpEffect with: 1.
	discreteProbabilityDistribution := DiscreteProbabilityDistribution 
		                                   withAll:
		                                   { speedUpProbabilityEvent }.
	source := DiscreteProbabilityEventSource with:
		          discreteProbabilityDistribution.

	effects := source next: 10.

	self assert: effects are: speedUpEffect
]
