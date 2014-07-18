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
                templateUrl: "views/template.html",
                controller: 'FloCtrl'
            })
            .state('flos.add', {
                url: "/add",
                views: {
                    'container': {
                        templateUrl: "views/flos/add.html"
                    }
                }
            })
            .state('flosAddAction', {
                url: "/flosAddAction",
                templateUrl: "views/flos/flosAddAction.html"
            })
            .state('addEndPoint', {
                url: "/addEndpoint",
                templateUrl: "views/flos/addEndPoint.html"
            })
  });
