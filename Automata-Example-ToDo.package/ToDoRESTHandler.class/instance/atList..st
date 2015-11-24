as yet unclassified
atList: listId
	<get>
	<path: '/{listId}'>
	<produces: 'text/json'>
	
	
	^ NeoJSONWriter toString: ((ToDoList defaultAt: listId) items collect: [: i | i asDictionary ]).
	
	"^ listId, itemId"