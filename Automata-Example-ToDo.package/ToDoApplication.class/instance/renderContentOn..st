as yet unclassified
renderContentOn: html
	ToDoList defaultInstances do: [ :list |
		html heading level: 1; with: list title.

		html orderedList:[
			list items do: [ :item |
				html listItem: [ 
					item isDone 
						ifTrue: [ html citation:  item title. html space. html anchor callback: [ list undone: item ]; with: 'Undone' ]
						ifFalse: [ html strong: item title. html space. html anchor callback: [ list done: item ]; with: 'Done' ].
					html space. 
					html anchor callback: [ list remove: item  ]; with: 'Remove' 
					].
					
		
				 ].
			html form: [ html textInput callback: [:v| list addTitle: v]. html submitButton ]
			]

		
		 ]