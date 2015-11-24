as yet unclassified
createList: listId
	<put>
	<path: '/{listId}'>
	<produces: 'text/json'>
	
	
	
	
	^NeoJSONWriter toString: (self requestContext request asString).
	
	"^ listId, itemId"