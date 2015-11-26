# automata-example

An example of Automata framework usage with a Seaside application.

Project consists of two parts:
- Seaside + REST application to manage several todo lists. Some actions trigger events which are sent to a remote event server
- Automata workflow - which "moves" tasks through the list according to some workflow rules.

Run the following code snipets on a fresh image to install everything.

#Installation
```smalltalk
Metacello new baseline: #AutomataExample; repository: 'github://mikefilonov/automata-example'; load.
```

# Seaside and REST configuration
```smalltalk
ZnZincServerAdaptor startOn: 8080.

ToDoApplication register. "http://localhost:8080/todo"
ToDoRESTHandler register. "http://localhost:8080/api/list"

ToDoList defaultInstances add: (ToDoList new title: 'planned').
ToDoList defaultInstances add: (ToDoList new title: 'in progress').
ToDoList defaultInstances add: (ToDoList new title: 'archive').
```


# Workflow configuration
```smalltalk
server := RATeapotController new.
server newAnnouncer: #first.
server startOn: 8081.

ToDoSingletonAnnouncer default url: 'http://localhost:8081/api/first' asUrl. "configure announcer of TODO application"

automata := RAAutomata new.
automata subscribeOn: (server announcerAt: #first).
automata start.

automata do: [ :task |
	[
	|event|
	event := task waitForEvent: [ :e | e selector = #ToDoItemAdded and: [ e list = 'planned' ] ].
	
	automata do: [ :subtask | |itemId|
		itemId := event item at: 'refId'.
		subtask waitForEvent: [ :e | e selector = #ToDoItemDone and: [ (e item at: 'refId')  = itemId ] ].
		
		ZnClient new
				beOneShot;
				url: ('http://localhost:8080/api/list/planned/{1}' format: {itemId});
				headerAt: 'destination' add: 'in progress';
				method: #MOVE;
				execute.
				
		ZnClient new
			beOneShot;
			url: ('http://localhost:8080/api/list/in progress/{1}/isDone' format: {itemId});
			method: #PUT;
			entity: ((ZnStringEntity type: ZnMimeType applicationJson) string: 'false'; 	yourself);
			execute.
			
		subtask waitForEvent: [ :e | e selector = #ToDoItemDone and: [ (e item at: 'refId')  = itemId ] ].
		
		ZnClient new
				beOneShot;
				url: ('http://localhost:8080/api/list/in progress/{1}' format: {itemId});
				headerAt: 'destination' add: 'archive';
				method: #MOVE;
				execute.		
				
			].
	 ]	repeat.
].
```
