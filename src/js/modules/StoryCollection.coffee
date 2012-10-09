# StoryCollection class in this function
StoryCollection = (Backbone) ->
	StoryCollection = Backbone.Collection.extend
		parse: (response) ->
			# News story models are under 'objects' in the JSON data
			return response.objects
	# Expose only the getInstance function
	return getInstance: ->
			# Use a singleton pattern for global data access
			if not storyCollectionSingleton?
				storyCollectionSingleton = new StoryCollection()
			return storyCollectionSingleton

# Necessary boilerplate to get require.js working
# on serverside for testing, as well as in browser
if not requirejs?
	amdefine = require('amdefine')(module)
	amdefine ["backbone"], (Backbone) ->
		# Satisfy dom library dependency
		Backbone.setDomLibrary require "jquery"
		return StoryCollection(Backbone)
else
	define ['libs/backbone'], (Backbone) ->
    	return StoryCollection(Backbone)