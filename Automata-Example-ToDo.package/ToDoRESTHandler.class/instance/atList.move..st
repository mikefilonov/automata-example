as yet unclassified
atList: listId move: itemId
	<move>
	<path: '/{listId}/{itemId}'>
	<produces: 'text/json'>
	|targetListId item|
	targetListId := (self requestContext request headerAt: 'destination').
	
	item := (ToDoList defaultAt: listId) at: itemId.
	(ToDoList defaultAt: listId) move: item to: (ToDoList defaultAt: targetListId) .
	
	
	
	^ NeoJSONWriter toString: ('ok').
	
	"^ listId, itemId"