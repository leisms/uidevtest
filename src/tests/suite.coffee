# Tests against UIDevTest requirements
# using Chai assertion library with BDD 'should' style
# Zombie.js, a headless browser
# and Require.js for unit testing modules
chai = require "chai"
zombie = require "zombie"
browser = new zombie()

# Include the full stacktrace in Chai assertion errors
chai.Assertion.includeStack = true
# Use BDD 'should' style
should = chai.should()

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
                    StoryCollection.models.should.have.length.above 0
                    done()
                error: ->
                    done new Error "Backbone.Collection.fetch() failed"

describe "Acceptance tests:", ->
    describe "User visiting /uidevtest/src/html/index.html", ->
        it "should receive status code 200", (done) ->
            browser.visit "http://localhost:#{port}/uidevtest/src/html/index.html", (e, browser) ->
                try
                    browser.statusCode.should.equal 200
                    done()
                catch err
                    done err
        it "should see a list of news headlines", (done) ->
            browser.visit "http://localhost:#{port}/uidevtest/src/html/index.html", (e, browser) ->
                try
                    should.exist browser.query ".headlines"
                    done()
                catch err
                    done err