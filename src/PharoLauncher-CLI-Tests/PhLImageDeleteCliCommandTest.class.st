Class {
	#name : #PhLImageDeleteCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageDeleteCliCommandTest >> testDeleteImageNameWithPathShouldRaiseError [
	|  imagePath root |
	root := FileSystem memory root.
	imagePath := root / 'testImage.image'.
	imagePath ensureCreateFile.
	

	self runCommand: {'launcher' . 'image' . 'delete' . imagePath asString }.
	self assertFailure.
	self
		assert:
			(self errorString
				includesSubstring: 'Please enter a correct local image').
	self assert: imagePath isFile.
]

{ #category : #tests }
PhLImageDeleteCliCommandTest >> testDeleteImageNameWithoutImageNameShouldRaiseError [
		
	self runCommand: #('launcher' 'image' 'delete').
 	self assertFailure.
	self assert: ( self errorString includesSubstring: 'specify the local image name to be deleted')
]

{ #category : #tests }
PhLImageDeleteCliCommandTest >> testDeleteImageShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'delete' 'myImage1').
	 
	self assertSuccess.  
	self assert: self imageRepository imagesName equals: #( 'myImage2' ) asSet. 
]

{ #category : #tests }
PhLImageDeleteCliCommandTest >> testDeleteImageWrongImageNameShouldRaiseError [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'delete' 'wrongImageName').
	self assertFailure.  
	self assert: (self errorString includesSubstring: 'Please enter a correct local image')
]
