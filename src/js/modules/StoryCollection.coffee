# StoryCollection class in this function
StoryCollection = (Backbone) ->
	StoryCollection = Backbone.Collection.extend

		# Backbone automatically calls this after fetching data
		parse: (response) ->
			# News story models are under 'objects' in the JSON data
			stories = response.objects
			for story, i in stories
				# Add some render-specific fields
				story.formatted_categories = "#{story.categories_name[0]} / #{story.categories_name[1]}"
				story.formatted_pub_date = @parseDate story.pub_date
				story.formatted_updated = @parseDate story.updated
				storyNum = i + 1
				if storyNum < 10 then storyNum = "0#{storyNum}"
				story.story_url = "?story=sto#{storyNum}"
			return stories

		parseDate: (unixDate) ->
			date = new Date(unixDate)
			
			dateStrings = date.toLocaleDateString().split ", "
			# toLocaleDateString() returns in format: "DAY, MONTH DATE, YEAR"
			day = dateStrings[0]
			month = dateStrings[1].split " "
			year = dateStrings[2]

			dateNum = month[1]
			month = month[0].substr 0,3

			time = date.toLocaleTimeString()
			# time is in format "HH:MM:SS"
			hour = parseInt time.substr 0,2
			minutes = time.substr 3,2
			if hour > 12
				hour -= 12
				period = "p.m."
			else
				period = "a.m."

			return "#{hour}:#{minutes} #{period} #{day}, #{month}. #{dateNum}, #{year}"

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