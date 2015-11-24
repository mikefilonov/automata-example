callbacks
undone: aToDoListItem
	aToDoListItem isDone: false.
	ToDoSingletonAnnouncer announce: (
		RASelectorAnnouncement 
			withSelector: #ToDoItemUnDone 
			andData: { 
				'list'-> self title. 
				'item'-> aToDoListItem asDictionary } asDictionary )