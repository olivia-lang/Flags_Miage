Class {
	#name : 'EarthMap',
	#superclass : 'Object',
	#instVars : [
		'countries'
	],
	#category : 'Flags_Miage',
	#package : 'Flags_Miage'
}

{ #category : 'accessing' }
EarthMap >> countries [
	^countries
]

{ #category : 'accessing' }
EarthMap >> countries: countriesCollection [
	countries := countriesCollection
]

{ #category : 'as yet unclassified' }
EarthMap >> importCountriesFrom: aFilename [

	| xmlTree paths |
	xmlTree := self xmlTreeFromFile: aFilename.
	paths := xmlTree allElementsNamed: 'path'.
	paths do: [ :each | self importCountryFromXMLNode: each ].
]

{ #category : 'accessing' }
EarthMap >> importCountryFromXMLNode: aXMLElement [
	"converts an XML node representing a country into a country object"
	
	countries add: (EarthMapCountry new fromXML: aXMLElement)
]

{ #category : 'initialization' }
EarthMap >> initialize [
	"class will import the country list"

	super initialize.
	countries := OrderedCollection new
]

{ #category : 'accessing' }
EarthMap >> openPopulatedCanvas [
	self populatedCanvas open
]

{ #category : 'accessing' }
EarthMap >> populatedCanvas [
	^RSCanvas new
		addAll: (countries collect: [ :country | country asRSShape]);
		@RSCanvasController;
		yourself
]

{ #category : 'accessing' }
EarthMap >> xmlTreeFromFile: aFileName [
	"return the corresponding XML tree of the given name"
	
	^aFileName asFileReference readStreamDo: [ :stream | (XMLDOMParser parse: stream) document ] 
]
