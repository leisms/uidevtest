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
# Tell the web server that we are testing
# so it uses dummy test data
process.env.TESTING = true

# Load the test data so we can compare
testData = JSON.parse (require "fs").readFileSync "tests/assets/uidevtest-data.js", "utf-8"

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
                    expect(browser.queryAll ".headline").to.have.length testData.objects.length
                    done()
                catch err
                    done err
        it "should see Headline Text, Picture, Categories, Posted Date and Updated Date in news headline list items", (done) ->
            browser.visit "http://localhost:#{port}/uidevtest/src/html/index.html", (e, browser) ->
                try
                    headlines = browser.queryAll ".headline"
                    for headline, i in headlines
                        expect(browser.text(".title", headline), "Title").to.equal testData.objects[i].title
                        expect(browser.text(".picture", headline), "Picture").to.exist testData.objects[i].lead_photo_image_url
                        expect(browser.text(".categories", headline), "Categories").to.exist testData.objects[i].categories_name
                        expect(browser.text(".postedDate", headline), "Posted Date").to.exist testData.objects[i].pub_date
                        expect(browser.text(".updatedDate", headline), "Updated Date").to.exist testData.objects[i].updated
                    done()
                catch err
                    done err