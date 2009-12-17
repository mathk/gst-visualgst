GtkConcreteWidget subclass: GtkImageWidget [
    | imageTree model searchEntry |

    initialize [
	<category: 'initialization'>

	self mainWidget: self buildMainWidget
    ]

    model [
        <category: 'accessing'>

        ^ model ifNil: [ model := GtkImageModel current ]
    ]

    buildMainWidget [
        <category: 'user interface'>

        ^ GTK.GtkVPaned new
            add1: self buildFinderEntry;
            add2: self buildClassAndMethodList;
            yourself
    ]

    buildFinderEntry [
        <category: 'user interface'>

        searchEntry := (GTK.GtkEntry new)
                            connectSignal: 'activate' to: self selector: #searchValidate userData: nil;
                            yourself.
        ^ (GTK.GtkHBox new: true spacing: 3)
            add: (GTK.GtkLabel new: 'Class or method :');
            add: searchEntry;
            yourself
    ]

    buildClassAndMethodList [
        <category: 'user interface'>

        imageTree := GTK.GtkTreeView newWithSortedTextColumn: self model gtkModel title: 'Methods and Classes'.
        self model isSorted ifFalse: [
            (imageTree getColumn: 0) signalEmitByName: 'clicked' args: {}.
            self model isSorted: true ].
        imageTree
            getSelection
                connectSignal: 'changed' to: self selector: #elementSelected userData: nil.
        imageTree setSearchEntry: searchEntry.
        ^ GTK.GtkScrolledWindow withChild: imageTree
    ]
]

