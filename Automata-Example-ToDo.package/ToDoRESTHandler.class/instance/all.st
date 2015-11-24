as yet unclassified
all
	<get>
	<path: '/'>
	<produces: 'text/json'>
	
	
	^ NeoJSONWriter toString: ((ToDoList defaultInstances) collect: [: i | i title ]).
	
	"^ listId, itemId"