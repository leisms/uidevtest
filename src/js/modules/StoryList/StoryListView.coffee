define [
    'jquery'
], ($) ->
    StoryListView = Backbone.View.extend
        template: 'StoryList/StoryListTemplate'
    return StoryListView