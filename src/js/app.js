// Require.js configuration and Backbone.js application loader

// fix for firefox text plugin bug
if (typeof Packages !== 'undefined') {
    Packages = undefined;
}

require.config({
    baseUrl: '/uidevtest/src/js/modules'
  , paths: {
        'libs': '../libs'
      , 'jquery': '../libs/jquery'
      , 'cs'  : '../libs/cs'
      , 'coffee-script': '../libs/coffee-script'
      , 'text': '../libs/text'
    }
  , shim: {
        'libs/underscore':               {exports: '_'}
      , 'libs/hogan':                    {exports: 'Hogan'}
      , 'libs/backbone':                 {deps: ['libs/underscore', 'libs/jquery', 'libs/hogan'], exports: 'Backbone'}
      , 'libs/backbone.layoutmanager':   ['libs/backbone']
      , 'libs/async':                    {exports: 'async'}
      , 'libs/mixpanel':                 {exports: 'mixpanel'}
    }
});
define(function () {
    require(['cs!../AppRouter'], function (AppRouter) {
        AppRouter.start();
    });
});