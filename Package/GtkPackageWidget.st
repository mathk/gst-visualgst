GtkConcreteWidget subclass: GtkPackageWidget [
    | packageTree column model |

    initialize [
	<category: 'initialization'>

	self mainWidget: self buildTreeView
    ]

    emptyModel [
	<category: 'accessing'>

	self clear
    ]

    clear [
        <category: 'accessing'>

        model clear
    ]

    buildTreeView [
        <category: 'user interface'>
    
	packageTree := (GTK.GtkTreeView createListWithModel: {{GtkColumnTextType title: 'Packages'}})
					connectSignal: 'button-press-event' to: self selector: #'onPress:event:';
					yourself.
	packageTree getSelection setMode: GTK.Gtk gtkSelectionBrowse.
        (model := GtkListModel on: packageTree getModel)
                                        contentsBlock: [ :each | {each name} ];
					item: PackageLoader root;
					refresh.
	^ GTK.GtkScrolledWindow withChild: packageTree
    ]

    onPress: aGtkWidget event: aGdkEvent [
        <category: 'button event'>

        | menu aGdkButtonEvent |
        aGdkButtonEvent := aGdkEvent castTo: GTK.GdkEventButton type.
        aGdkButtonEvent button value = 3 ifFalse: [ ^ false ].
        menu := GTK.GtkMenu new.
        menu appendMenuItems: {{'Load it'. self. #loadIt}.
		{}.
		{'Inspect it'. self. #inspectIt}}.
        menu attachToWidget: packageTree detacher: nil.
        menu popup: nil parentMenuItem: nil func: nil data: nil button: 3 activateTime: aGdkButtonEvent time value.
        menu showAll.
        ^ true
    ]

    unselectAll [
	<category: 'selection'>

	packageTree getSelection unselectAll
    ]

    whenSelectionChangedSend: aSelector to: anObject [
	<category: 'events'>

	packageTree getSelection
	    connectSignal: 'changed' to: anObject selector: aSelector userData: nil
    ]

    hasSelectedPackage [
	<category: 'testing'>

	^ packageTree hasSelectedItem
    ]

    selectedPackage [
	<category: 'accessing'>

	self hasSelectedPackage ifFalse: [ self error: 'nothing is selected' ].
	^ packageTree selection
    ]

    selectAPackage: aPackage [
        <category: 'item selection'>

	packageTree select: aPackage
    ]

    findIterInAPackage: aString [
        <category: 'item selection'>

        | result |

        result := self model findIterInAPackage: aString.
        packageTree scrollToCell: (self model gtkModel getPath: result) column: nil useAlign: false rowAlign: 0.5 colAlign: 0.5.
        ^ result
    ]

    viewedPackageWidget [
	<category: 'accessing'>

	^ self
    ]

    viewedPackageModel [
	<category: 'accessing'>

	^ self model
    ]

    loadIt [
	<category: 'model event'>

	self hasSelectedPackage ifFalse: [ ^ self ].
	PackageLoader fileInPackage: self selectedPackage name
    ]

    inspectIt [
        <category: 'model event'>

        self hasSelectedPackage ifFalse: [ ^ self ].
        GtkInspector openOn: self selectedPackage
    ]
]

