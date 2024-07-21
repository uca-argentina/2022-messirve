Class {
	#name : 'ProbabilityEvent',
	#superclass : 'Object',
	#instVars : [
		'event',
		'probability'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'asserting' }
ProbabilityEvent class >> assertCorrectProbabilityOf: aProbability [

	(aProbability between: 0 and: 1) ifFalse: [ 
		Error signal: 'Probability must be between 0 and 1' ]
]

{ #category : 'initialization' }
ProbabilityEvent class >> of: anEvent with: aProbability [

	self assertCorrectProbabilityOf: aProbability.
	^ self new initializeOf: anEvent with: aProbability
]

{ #category : 'accessing' }
ProbabilityEvent >> event [

	^ event
]

{ #category : 'initialization' }
ProbabilityEvent >> initializeOf: anEvent with: aProbability [

	event := anEvent.
	probability := aProbability
]

{ #category : 'initialization' }
ProbabilityEvent >> probability [

	^ probability
]
