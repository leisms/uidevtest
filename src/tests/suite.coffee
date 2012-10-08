# Tests against UIDevTest requirements
# using Chai assertion library with BDD 'should' style
# Zombie.js, a headless browser
# and Require.js for unit testing modules
chai = require "chai"
zombie = require "zombie"

chai.Assertion.includeStack = true
should = chai.should()
browser = new zombie()

# Set a free port for testing
port = process.env.PORT = 8888

# Start the server
server = require "../app.coffee"

describe "Unit tests:", ->
    describe "Loading and parsing uidevtest-data.js", ->
        it "should load correctly into a Backbone collection", (done) ->
            StoryCollection = require "../js/modules/StoryCollection"
            done()

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