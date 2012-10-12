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

        it "parseDate()", (done) ->
            expect(StoryCollection.parseDate "2012-09-04T12:02:26-07:00").to.equal "3:02 p.m. Tuesday, Sep. 04, 2012"
            done()

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
                        expect(browser.query(".picture", headline).getAttribute "src", "Picture").to.equal testData.objects[i].lead_photo_image_thumb
                        expect(browser.text(".categories", headline), "Categories").to.equal "#{testData.objects[i].categories_name[0]} / #{testData.objects[i].categories_name[1]}"
                        expect(browser.text(".postedDate", headline), "Posted Date").to.equal testData.objects[i].test_pub_date
                        expect(browser.text(".updatedDate", headline), "Updated Date").to.equal testData.objects[i].test_updated
                    done()
                catch err
                    done err
        it "should browse to the full article when a news headline is clicked", (done) ->
            browser.visit "http://localhost:#{port}/uidevtest/src/html/index.html", (e, browser) ->
                try
                    browser.clickLink testData.objects[0].title, ->
                        try
                            expect(browser.location.href).to.equal "http://localhost:#{port}/uidevtest/src/html/index.html?story=sto01"
                            done()
                        catch err
                            done err
                catch err
                    done err
    describe "User visiting /uidevtest/src/html/index.html?story=stoXX", ->
        it "should receive status code 200", (done) ->
            browser.visit "http://localhost:#{port}/uidevtest/src/html/index.html?story=sto01", (e, browser) ->
                try
                    expect(browser.statusCode).to.equal 200
                    done()
                catch err
                    done err
        it "should see a full news article", (done) ->
            browser.visit "http://localhost:#{port}/uidevtest/src/html/index.html?story=sto01", (e, browser) ->
                try
                    expect(browser.query(".article"), "Article").to.exist
                    done()
                catch err
                    done err
        it "should see Headline Text, Picture, Picture Caption, Picture Credit, Article Text, Author, Posted Date and Updated Date in full article view", (done) ->
            browser.visit "http://localhost:#{port}/uidevtest/src/html/index.html", (e, browser) ->
                try
                    headlines = browser.queryAll ".headline"
                    expect(browser.text(".title", headline), "Title").to.equal testData.objects[0].title
                    expect(browser.query(".picture", headline).getAttribute "src", "Picture").to.equal testData.objects[0].lead_photo_image_url
                    expect(browser.text(".pictureCaption", headline), "Picture Caption").to.equal testData.objects[0].lead_photo_credit
                    expect(browser.html(".articleText", headline), "Article Text").to.equal testData.objects[0].story
                    expect(browser.text(".author", headline), "Author").to.equal testData.objects[0].author
                    expect(browser.text(".postedDate", headline), "Posted Date").to.equal testData.objects[0].test_pub_date
                    expect(browser.text(".updatedDate", headline), "Updated Date").to.equal testData.objects[0].test_updated
                    done()
                catch err
                    done err