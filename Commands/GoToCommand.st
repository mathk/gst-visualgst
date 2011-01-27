OpenBrowserCommand subclass: GoToCommand [

    buildBrowserAndSelect: anAssociation [
	<category: 'user interface'>

        target currentWidgetOfBrowser selectANamespace: anAssociation key.
        anAssociation value ifNotNil: [ target currentWidgetOfBrowser selectAClass: anAssociation value ].
    ]

    execute [
        <category: 'command'>

	self buildBrowserAndSelect: self selection
    ]
]

