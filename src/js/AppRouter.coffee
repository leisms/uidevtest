define ["libs/backbone", "libs/backbone.layoutmanager"], ->
    AppRouter = Backbone.Router.extend
        initialize: ->
            # Use Tim Branyen"s excellent Backbone layout manager
            # enabling us to easily chain view rendering and also
            # automate the loading of module templates
            Backbone.LayoutManager.configure
                # Enables layoutmanager when extending Backbone.View
                manage: true
                # Override the fetch function to return plaintext templates
                fetch: (name) ->
                    # Asynchronously load template and styles for view based on root name
                    done = @async()
                    require ["text!#{name}.hogan"], (template) ->
                        done (context) ->
                            Hogan.compile(template).render(context)

            # Require the main application window and render it
            require ["cs!Main/MainView"], (MainView) =>
                @mainView = new MainView()
                Backbone.history.start pushState: true

        routes: 
            "uidevtest/src/html/index.html": "renderStoryList"
            "uidevtest/src/html/index.html?story=sto:storyNum": "renderStory"
            "*404": "404" # The asterisk catches all missed routes
        renderStoryList: ->
            @mainView.renderStoryList()
        renderStory: (storyNum) ->
            @mainView.renderStory parseInt storyNum-1
        404: ->
            console.log "404"
            Backbone.history.navigate "uidevtest/src/html/index.html", true
    return start: ->
        new AppRouter()
