accessing
at: itemTitle
	^self items detect: [ :i | i refId = itemTitle ]