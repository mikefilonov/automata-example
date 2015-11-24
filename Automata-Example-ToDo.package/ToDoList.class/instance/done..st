callbacks
done: aToDoListItem
	aToDoListItem isDone: true.
	ToDoSingletonAnnouncer announce: (
		RASelectorAnnouncement 
			withSelector: #ToDoItemDone 
			andData: { 
				'list'-> self title. 
				'item'-> aToDoListItem asDictionary } asDictionary )