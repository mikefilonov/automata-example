as yet unclassified
atList: listId at: itemId
	<get>
	<path: '/{listId}/{itemId}'>
	<produces: 'text/json'>
	
	
	^ NeoJSONWriter toString: ((ToDoList defaultAt: listId) at: itemId) asDictionary.
	
	"^ listId, itemId"