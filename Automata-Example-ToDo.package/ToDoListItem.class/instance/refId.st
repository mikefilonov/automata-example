accessing
refId
	^refId ifNil: [ refId := UUID new asString36 ]