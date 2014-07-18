'use strict';

angular.module('floRidaApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router'
])
  .config(function ($stateProvider, $urlRouterProvider) {
        // For any unmatched url, redirect to /state1
        $urlRouterProvider.otherwise("/flos");
        //
        // Now set up the states
        $stateProvider
            .state('flos', {
                url: "/flos",
                templateUrl: "views/flos/index.html"
            })
            .state('flos.add', {
                url: "/add",
                views: {
                    '': {
                        templateUrl: "views/flos/add.html"
                    }
                }
            })
            .state('addEndPoint', {
                url: "/addEndpoint",
                templateUrl: "views/flos/addEndPoint.html"
            })
  });
