# Tests against UIDevTest requirements
# using Chai assertion library and BDD 'should' style
# and using Zombie.js, a headless browser
Chai = require "chai"
Zombie = require "zombie"

Chai.Assertion.includeStack = true
should = Chai.should()
browser = new Zombie()

# Set a free port for testing
port = process.env.PORT = 8888

# Start the server
server = require "../app.coffee"

describe "Acceptance tests", ->
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