callbacks
move: aToDoListItem to: anotherList
	self remove: aToDoListItem.
	anotherList items add: aToDoListItem. "no announcement"
