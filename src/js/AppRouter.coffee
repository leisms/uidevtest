define ['libs/backbone', 'libs/backbone.layoutmanager'], ->
    AppRouter = Backbone.Router.extend
        initialize: ->
            ### Google Analytics initialization code
            window._gaq = window._gaq || []
            window._gaq.push ['_setAccount', 'YOUR GA ID']
            window._gaq.push ['_setDomainName', 'example.com']

            require ['https://ssl.google-analytics.com/ga.js'], ->
                window._gaq.push ['_trackPageview']
            ###
            ### Mixpanel initialization code
            require ['libs/mixpanel'], (mixpanel) ->
                mixpanel?.init 'YOUR MIXPANEL APIKEY'
                mixpanel?.identify(mixpanel.get_property('distinct_id'))
                if document.referrer
                    mixpanel?.people.set("referrer", document.referrer);
            ###

            # Use Tim Branyen's excellent Backbone layout manager
            # enabling us to easily chain view rendering and also
            # automate the loading of module templates and css
            Backbone.LayoutManager.configure
                # Enables layoutmanager when extending Backbone.View
                manage: true
                # Override the fetch function to return plaintext templates
                fetch: (name) ->
                    # Asynchronously load template and styles for view based on root name
                    done = @async()
                    require ["text!#{name}.hogan", "css!#{name}.css"], (template) ->
                        done (context) ->
                            Hogan.compile(template).render(context)

            # Require the main application window and render it
            require ['cs!Main/MainView'], (MainView) ->
                mainView = new MainView()
                mainView.render()
                Backbone.history.start pushState: true

        routes: 
            '': 'home'
            '*404': '404' # The asterisk catches all missed routes
        home: ->
            console.log 'Home!'
        404: ->
            console.log '404'
            Backbone.history.navigate '/', true
    return start: ->
        new AppRouter()
