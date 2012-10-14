# Use Express, a sinatra inspired web app framework
express = require "express"
app = express()

# Use PORT environment variable if it exists (for Heroku)
port = process.env.PORT or 8080

# Configure Express to route static files and folders
app.configure ->
    # If testing, use test data
    if process.env.TESTING
        app.use "/uidevtest/src/js/assets/", express.static "#{__dirname}/tests/assets"
    app.use "/uidevtest", express.static "#{__dirname}/../"
    # Fix for browsers that do not support pushState
    app.use "/js", express.static "#{__dirname}/js"
    app.use "/css", express.static "#{__dirname}/css"
    app.use app.router

# Serve the main web app
html = (require "fs").readFileSync "html/index.html", "utf-8"
# Fix for browsers that do not support pushState
app.get "/", (req, res) ->
    res.set "Content-Type", "text/html"
    res.send html

# Start the web servers
app.listen port
console.log "Server listening on port #{port}"