GtkBrowsingTool subclass: GtkPackage [
    | webview |

    GtkPackage class >> openOn: aString [
        <category: 'user interface'>

        ^ (self openSized: 450@375)
	    url: aString
    ]

    GtkPackage class >> open [
	<category: 'user interface'>

	^ self openSized: 450@375
    ]

    windowTitle [
	<category: 'accessing'>

        ^ 'Package'
    ]

    aboutTitle [
	<category: 'accessing'>

	^ 'About Package'
    ]

    buildPackageView [

	^ (GtkPackageWidget showAll)
			    mainWidget
    ]

    buildPackage [

        ^ GTK.GtkHPaned new
            pack1: self buildPackageView resize: true shrink: false;
            showAll;
            yourself
    ]

    buildCentralWidget [
	<category: 'intialize-release'>

	^ self buildPackage
	"^ (GTK.GtkScrolledWindow withChild: self buildPackage)
	    showAll; 
	    yourself"
    ]

    hasChanged [
	<category: 'testing'>

	^ false
    ]
]

