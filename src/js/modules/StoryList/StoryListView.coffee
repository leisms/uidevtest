# View module for displaying a list of story headlines

define [
    "jquery"
    "cs!StoryCollection"
], ($, StoryCollection) ->
    StoryListView = Backbone.View.extend
        template: "StoryList/StoryListTemplate"
        initialize: ->
            @stories = StoryCollection.getInstance()
            # When the collection updates, re-render this view
            @stories.on "reset", =>
                @render()
            if @stories.length is 0
                @stories.url = "/uidevtest/src/js/assets/uidevtest-data.js"
                @stories.fetch()
            else
                @render()
        serialize: ->
            return stories: @stories.toJSON()
        afterRender: ->
            document.title = "Pawnee News Network - Headlines"
        events:
            "click .headline .title a": "viewStory"
        viewStory: (event) ->
            event.preventDefault()
            Backbone.history.navigate "#{window.location.pathname}#{event.target.getAttribute 'href'}", true
    return StoryListView