callbacks
add: aToDoListItem
	self items add: aToDoListItem.
	ToDoSingletonAnnouncer announce:(
		RASelectorAnnouncement 
				withSelector: #ToDoItemAdded 
				andData: { 
					'list'-> self title. 
					'item'-> aToDoListItem asDictionary } asDictionary)