accessing
itemsCollection
	^ itemsCollection ifNil: [ itemsCollection := OrderedCollection new ]