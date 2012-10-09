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
    return StoryListView