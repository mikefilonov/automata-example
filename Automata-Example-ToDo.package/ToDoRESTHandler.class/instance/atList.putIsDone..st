as yet unclassified
atList: listId putIsDone: itemId
	<put>
	<path: '/{listId}/{itemId}/isDone'>
	<produces: 'text/json'>
	
	 ((ToDoList defaultAt: listId) at: itemId) isDone: (NeoJSONReader fromString: self requestContext request rawBody).
	

	^ NeoJSONWriter toString: ((ToDoList defaultAt: listId) at: itemId) isDone.
	
	"^ listId, itemId"