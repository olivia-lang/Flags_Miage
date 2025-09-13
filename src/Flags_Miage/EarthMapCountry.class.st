Class {
	#name : 'EarthMapCountry',
	#superclass : 'Object',
	#instVars : [
		'svgPath',
		'name',
		'code'
	],
	#classInstVars : [
		'code'
	],
	#category : 'Flags_Miage',
	#package : 'Flags_Miage'
}

{ #category : 'instance creation' }
EarthMapCountry >> asRSShape [
	"return the Roassal SVG shape of a country"

	^RSSVGPath new svgPath: svgPath
]

{ #category : 'accessing' }
EarthMapCountry >> code [
	^code
]

{ #category : 'accessing' }
EarthMapCountry >> code: aCode [
	code := aCode
]

{ #category : 'instance creation' }
EarthMapCountry >> fromXML: aXMLElement [
	"create an instance of EarthMapCountry from an XML element"

	svgPath := aXMLElement attributeAt: 'd'.
	name := aXMLElement attributeAt: 'title'.
	code := aXMLElement attributeAt: 'id'.
]

{ #category : 'instance creation' }
EarthMapCountry >> inspectorShape: aBuilder [
	"shape the country and display in the inspector"

	<inspectorPresentationOrder: 0 title: 'Shape'>
	
	| canvas |
	canvas := RSCanvas new.
	canvas add: self asRSShape.
	canvas@RSCanvasController .
	^SpRoassalInspectorPresenter new canvas: canvas; yourself
]

{ #category : 'accessing' }
EarthMapCountry >> name [
	^name
]

{ #category : 'accessing' }
EarthMapCountry >> name: aName [
	name := name
]

{ #category : 'instance creation' }
EarthMapCountry >> printOn: aStream [
	"print information"
	
	super printOn: aStream.
	aStream nextPutAll: ' ', name
]

{ #category : 'accessing' }
EarthMapCountry >> svgPath [
	^svgPath 
]

{ #category : 'accessing' }
EarthMapCountry >> svgPath: aSVGPath [
	svgPath := aSVGPath
]
