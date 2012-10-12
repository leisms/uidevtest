# Main application view wrapper
# Includes logic for pushstate link events and other global events

define [
    'jquery'
  , 'cs!StoryList/StoryListView'
  , 'cs!Story/StoryView'
], ($, StoryListView, StoryView) ->
    MainView = Backbone.View.extend
        template: 'Main/MainTemplate'
        initialize: ->
            $('body').empty().append(@el)
        events:
            # override internal links with pushstate navigation
            'click .pushState': 'pushStateNavigate'
            # track external site clicks
            'click a:not(.pushstate)': 'externalSiteNavigate'
        pushStateNavigate: (event) ->
            event.preventDefault()
            Backbone.history.navigate($(event.currentTarget).attr('href'), true)
        externalSiteNavigate: (event) ->
            #alert($(event.currentTarget).attr('href'));
        renderStoryList: ->
            @setView ".content", new StoryListView()
            @render()
        renderStory: (storyNum) ->
            @setView ".content", new StoryView(storyNum)
            @render()
    return MainView