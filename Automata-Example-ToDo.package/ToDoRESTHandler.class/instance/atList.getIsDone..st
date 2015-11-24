as yet unclassified
atList: listId getIsDone: itemId
	<get>
	<path: '/{listId}/{itemId}/isDone'>
	<produces: 'text/json'>
	
	
	^ NeoJSONWriter toString: ((ToDoList defaultAt: listId) at: itemId) isDone.
	
	"^ listId, itemId"