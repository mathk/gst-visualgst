GTK.GtkAccelGroup class extend [

    acceleratorParse: accelerator [
	<category: 'C call-outs'>

	| cAccKey cAccMod |
	cAccKey := CInt value: 0.
	cAccMod := CInt value: 0.
	GTK.Gtk acceleratorParse: accelerator acceleratorKey: cAccKey acceleratorMods: cAccMod.
	^ {cAccKey value. cAccMod value}
    ]

    acceleratorGroup: aGtkAccelGroup accelerator: aString path: aPathString [
	<category: 'C call-outs'>

	| result |
	result := self acceleratorParse: aString.
	GTK.GtkAccelMap addEntry: aPathString accelKey: result first accelMods: result second
    ]
]

GTK.GtkAccelGroup extend [

    connect: accelKey accelModes: accelMods accelFlags: accelFlags receiver: receiver selector: selector [
	<category: 'C call-outs'>

	<cCall: 'gstGtkConnectAccelGroupNoUserData' returning: #void
	args: #( #selfSmalltalk #int #int #int #smalltalk #smalltalk )>
    ]

    append: anArray [
        <category: 'accessing'>

        anArray do: [ :each |
            self class
                acceleratorGroup: self
                accelerator: each first
                path: each second ]
    ]
]
