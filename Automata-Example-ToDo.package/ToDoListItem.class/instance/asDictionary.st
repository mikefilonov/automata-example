accessing
asDictionary
	^	Dictionary new 
			at: 'refId' put: self refId;
			at: 'title' put: self title;
			at: 'isDone' put: self isDone;
			yourself.