Object subclass: UndoStack [

    | undoStack redoStack |

    initialize [
	<category: 'initialization'>

	undoStack := OrderedCollection new.
	redoStack := OrderedCollection new.
    ]

    clear [
	<category: 'stack'>

	redoStack empty.
	undoStack empty
    ]

    push: aCommand [
	<category: 'stack'>

	aCommand redo.
	redoStack empty.
	undoStack addFirst: aCommand
    ]

    pop [
	<category: 'stack'>

	undoStack first undo.
	undoStack removeFirst
    ]

    undo [
	<category: 'undo-redo'>

	| cmd |
	undoStack isEmpty ifTrue: [ ^ self ].

	cmd := undoStack first
		    undo;
		    yourself.
	redoStack addFirst: undoStack removeFirst.
    ]

    redo [
        <category: 'undo-redo'>

        | cmd |
	redoStack isEmpty ifTrue: [ ^ self ].

        cmd := redoStack first
		    redo;
		    yourself.
        undoStack addFirst: redoStack removeFirst.
    ]
]
