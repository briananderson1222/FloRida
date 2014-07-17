'use strict';

angular.module('floRidaApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router'
])
  .config(function ($stateProvider, $urlRouterProvider) {
        // For any unmatched url, redirect to /state1
        $urlRouterProvider.otherwise("/");
        //
        // Now set up the states
        $stateProvider
            .state('flos', {
                url: "/",
                templateUrl: "views/flos/index.html"
            })
            .state('flos.add', {
                url: "/",
                templateUrl: "views/flos/add.html"
            })
  });
