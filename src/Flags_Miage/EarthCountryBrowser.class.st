Class {
	#name : 'EarthCountryBrowser',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'countryList',
		'countryCode',
		'countryFlag',
		'roassalView'
	],
	#category : 'Flags_Miage',
	#package : 'Flags_Miage'
}

{ #category : 'initialization' }
EarthCountryBrowser >> connectPresenters [
	"define interaction betzeen elements"
	
	countryList whenSelectedItemChangedDo: [ :item | self onCountrySelected: item ].
]

{ #category : 'initialization' }
EarthCountryBrowser >> defaultLayout [
	
	^SpBoxLayout newTopToBottom
		add: (SpBoxLayout newLeftToRight 
				add: countryList expand: true;
				add: countryCode width: 40)
		height: self class toolbarHeight ;
		add: countryFlag height: 350;
		add: roassalView expand: true;
		yourself
]

{ #category : 'initialization' }
EarthCountryBrowser >> flagForCountryCode: aString [
	"fetch flags"
	
	| request pngArray |
	request := ZnClient new.
	request get: 'https://flagcdn.com/w320/', aString asLowercase ,'.png'.
	request isSuccess ifTrue: [ pngArray := request response contents.
		^ImageReadWriter formFromStream: (ReadStream on: pngArray) ].
	^BorderedMorph new asForm
]

{ #category : 'initialization' }
EarthCountryBrowser >> initializePresenters [ 
	"initialize presenters for the interface"

	super initializePresenters .
	
	roassalView := SpRoassalPresenter new.
	roassalView canvas: (EarthMap new importCountriesFrom: (FileSystem workingDirectory/'world.svg');
		populatedCanvas ).
	
	countryList := self newDropList .
	countryList display: [ :item | item name ].
	countryList sortingBlock: [ :a :b | a model name < b model name ].
	countryList items: self model countries.
	
	countryCode := self newTextInput.
	countryCode editable: false.
	countryCode text: ' -- '.

	countryFlag := self newImage
]

{ #category : 'initialization' }
EarthCountryBrowser >> onCountrySelected:	countryItem [
	"display code and flag of the country"
	
	countryCode text: '    ', countryItem code.
	countryFlag image: (self flagForCountryCode: countryItem code)
]
