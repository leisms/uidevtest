# Use Express, a sinatra inspired web app framework
express = require "express"
app = express()

# Use PORT environment variable if it exists (for Heroku)
port = process.env.PORT or 8080

# Configure Express to route static files and folders
app.configure ->
    app.use "/uidevtest", express.static "#{__dirname}/../"
    app.use app.router

# Start the web servers
app.listen port
console.log "Server listening on port #{port}"