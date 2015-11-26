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

After the code above is run on Pharo open http://localhost:8080/todo to see the web application. Test it by adding a new item to "planned" list and checking it as "Done". Nothing happens :) Well as no workflow is running why something should happen, right?

Let's configure a simple workflow: when a user clicks "done" in the "planned" list it will be moved to the "in progress" list. When the user again click "Done" the item will be moved to the "archive" list. Please see the code below to configure an automata workflow for that.

Note automata event listener uses a different port (8081) and can be run in a different VM.

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

Test again by creating a new item in "planned" and clicking "done" in the list.

#Related projects
- https://github.com/mikefilonov/automata  - a core for microservices communication
- https://github.com/mikefilonov/restannouncer - HTTP/JSON announcements framework
