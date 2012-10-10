define [
    "jquery"
    "cs!StoryCollection"
], ($, StoryCollection) ->
    StoryListView = Backbone.View.extend
        template: "StoryList/StoryListTemplate"
        initialize: ->
        	@.stories = StoryCollection.getInstance()
        	@.stories.url = "/uidevtest/src/js/assets/uidevtest-data.js"
        	@.stories.fetch()
        serialize: ->
        	return stories: @.stories.toJSON()
        events:
        	"click .headline .title a": "viewStory"
        viewStory: (event) ->
        	event.preventDefault()
        	Backbone.history.navigate window.location.pathname + event.target.getAttribute "href"
    return StoryListView