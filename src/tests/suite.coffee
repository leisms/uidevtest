# Tests against UIDevTest requirements
# using Chai assertion library with BDD 'expect' style
# Zombie.js, a headless browser
# and Require.js for unit testing modules
chai = require "chai"
zombie = require "zombie"
browser = new zombie()

# Include the full stacktrace in Chai assertion errors
chai.Assertion.includeStack = true
# Use BDD 'expect' style
expect = chai.expect

# Set a free port for testing
port = process.env.PORT = 8888

# Start the server
server = require "../app.coffee"

describe "Unit tests:", ->
    describe "StoryCollection", ->

        # Get an instance of the StoryCollection singleton
        StoryCollection = (require "../js/modules/StoryCollection").getInstance()

        it "fetch()", (done) ->
            StoryCollection.url = "http://localhost:#{port}/uidevtest/src/js/assets/uidevtest-data.js"
            StoryCollection.fetch
                success: ->
                    expect(StoryCollection.models).to.have.length.above 0
                    done()
                error: ->
                    done new Error "Backbone.Collection.fetch() failed"

describe "Acceptance tests:", ->
    describe "User visiting /uidevtest/src/html/index.html", ->
        it "should receive status code 200", (done) ->
            browser.visit "http://localhost:#{port}/uidevtest/src/html/index.html", (e, browser) ->
                try
                    expect(browser.statusCode).to.equal 200
                    done()
                catch err
                    done err
        it "should see a list of news headlines", (done) ->
            browser.visit "http://localhost:#{port}/uidevtest/src/html/index.html", (e, browser) ->
                try
                    expect(browser.query(".headlines"), "List of news headlines").to.exist
                    done()
                catch err
                    done err
        it "should see Headline Text, Picture, Categories, Posted Date and Updated Date in news headline list items", (done) ->
            browser.visit "http://localhost:#{port}/uidevtest/src/html/index.html", (e, browser) ->
                try
                    headlines = browser.queryAll ".headlines"
                    headline = headlines.pop()
                    expect(browser.query(".title", headline), "Title").to.exist
                    expect(browser.query(".picture", headline), "Picture").to.exist
                    expect(browser.query(".categories", headline), "Categories").to.exist
                    expect(browser.query(".postedDate", headline), "Posted Date").to.exist
                    expect(browser.query(".updatedDate", headline), "Updated Date").to.exist
                    done()
                catch err
                    done err