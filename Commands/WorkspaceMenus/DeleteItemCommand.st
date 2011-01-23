Command subclass: DeleteItemCommand [

    item [

	^ 'Delete variable'
    ]

    valid [
	<category: 'command'>

        ^ target hasSelectedValue
    ]

    execute [
	<category: 'command'>

        target deleteVariable
    ]
]

