define [
    "jquery"
    "cs!StoryCollection"
], ($, StoryCollection) ->
    StoryView = Backbone.View.extend
        template: "Story/StoryTemplate"
        initialize: (storyNum) ->
            stories = StoryCollection.getInstance()
            stories.on "reset", =>
                @story = stories.at storyNum
                @render()
            if stories.length is 0
                stories.url = "/uidevtest/src/js/assets/uidevtest-data.js"
                stories.fetch()
            else
                @story = stories.at storyNum
                @render()
        serialize: ->
            return story: @story?.toJSON()
        afterRender: ->
            document.title = "Pawnee News Network - #{@story?.get('title')}"
    return StoryView