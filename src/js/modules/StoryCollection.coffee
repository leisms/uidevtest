# necessary boilerplate for serverside require.js testing
backboneDir = "libs/backbone"
if !define? then define = require("amdefine")(module); backboneDir = "backbone"

define [backboneDir], (Backbone) ->
    StoryCollection = Backbone.Collection.extend
    return StoryCollection