# Collection for fetching and parsing of stories

StoryCollection = (Backbone, Moment) ->
    StoryCollection = Backbone.Collection.extend
        # Backbone automatically calls this after fetching data
        parse: (response) ->
            # News story models are under "objects" in the JSON data
            stories = response.objects
            for story, i in stories
                # Add some render-specific fields
                if story.categories_name[1]?
                    story.formatted_categories = "#{story.categories_name[0]} / #{story.categories_name[1]}"
                else
                    story.formatted_categories = story.categories_name[0]
                story.formatted_pub_date = @parseDate story.pub_date
                story.formatted_updated = @parseDate story.updated
                storyNum = i + 1
                if storyNum < 10 then storyNum = "0#{storyNum}"
                # Set Window.location.href for testing
                if not window? then window = location: pathname: "/uidevtest/src/html/index.html"
                story.story_url = "#{window.location.pathname}?story=sto#{storyNum}"
            return stories

        parseDate: (unixDate) ->
            date = Moment unixDate
            # Customize Moment to print out a.m./p.m. instead of am/pm
            Moment.meridiem = (hour, minute, isLower) ->
                if hour < 12 then return "a.m." else return "p.m."

            return date.format "h:mm a dddd, MMM. DD, YYYY"

    # Expose only the getInstance function
    # and use a singleton pattern for global data access
    storyCollectionSingleton = undefined
    return getInstance: =>
        if not @storyCollectionSingleton?
            @storyCollectionSingleton = new StoryCollection()
        return @storyCollectionSingleton

# Necessary boilerplate to get require.js working
# on serverside for testing, as well as in browser
if not requirejs?
    amdefine = require("amdefine")(module)
    amdefine ["backbone", "moment"], (Backbone, Moment) ->
        # Satisfy dom library dependency
        Backbone.setDomLibrary require "jquery"
        return StoryCollection(Backbone, Moment)
else
    define ["libs/backbone", "libs/moment"], (Backbone, Moment) ->
        return StoryCollection(Backbone, Moment)