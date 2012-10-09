define [
    "jquery"
    "cs!StoryCollection"
], ($, StoryCollection) ->
    StoryListView = Backbone.View.extend
        template: "StoryList/StoryListTemplate"
        initialize: ->
        	@stories = StoryCollection.getInstance()
    return StoryListView