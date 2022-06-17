Class {
	#name : #NumberInterval,
	#superclass : #Object,
	#instVars : [
		'startingAt',
		'endingAt'
	],
	#classInstVars : [
		'startingAt',
		'endingAt'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
NumberInterval class >> goingFrom: start to: end [

	^ self new initializeGoingFrom: start to: end
]

{ #category : #comparing }
NumberInterval >> contains: aNumber [

	^ aNumber between: startingAt and: endingAt
]

{ #category : #initialization }
NumberInterval >> initializeGoingFrom: start to: end [

	startingAt := start.
	endingAt := end
]
