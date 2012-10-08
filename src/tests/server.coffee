# Tests against UIDevTest requirements
# using Chai assertion library and BDD 'should' style
# and using Zombie.js, a headless browser
Chai = (require "chai").should()
Zombie = require "zombie"
browser = new Zombie()

# Set a free port for testing
port = process.env.PORT = 8888

# Start the server
server = require "../app.coffee"

describe "Web Server", ->
    describe "handling requests", ->
        describe "visit /uidevtest/src/html/index.html", ->
            it "should respond with status code 200", (done) ->
                browser.visit "http://localhost:#{port}/uidevtest/src/html/index.html", (e, browser) ->
                    browser.statusCode.should.equal 200
                    done()