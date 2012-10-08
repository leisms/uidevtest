// Require.js configuration and Backbone.js application loader

// fix for firefox text plugin bug
if (typeof Packages !== 'undefined') {
    Packages = undefined;
}

require.config({
    baseUrl: 'app/modules'
  , paths: {
        'libs': '../libs'
      , 'jquery': '../libs/jquery'
      , 'cs'  : '../libs/cs'
      , 'coffee-script': '../libs/coffee-script'
      , 'css' : '../libs/css'
      , 'text': '../libs/text'
    }
  , shim: {
        'libs/underscore':               {exports: '_'}
      , 'libs/hogan':                    {exports: 'Hogan'}
      , 'libs/backbone':                 {deps: ['libs/underscore', 'libs/jquery', 'libs/hogan'], exports: 'Backbone'}
      , 'libs/backbone.layoutmanager':   ['libs/backbone']
      , 'libs/bootstrap':                ['libs/jquery','css!libs/bootstrap.css']
      , 'libs/async':                    {exports: 'async'}
      , 'libs/mixpanel':                 {exports: 'mixpanel'}
    }
});
define(['css!libs/normalize.css'], function () {
    require(['cs!../AppRouter'], function (AppRouter) {
        AppRouter.start();
    });
});