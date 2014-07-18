'use strict';

angular.module('floRidaApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router',
  'ui.bootstrap.tpls',
  'ui.bootstrap.modal'
])
  .config(function ($stateProvider, $urlRouterProvider) {

        // For any unmatched url
        $urlRouterProvider.otherwise("/flos");
        //
        // Now set up the states
        $stateProvider
            .state('flos', {
                url: "/flos",
                views: {
                    '': {
                        templateUrl: "views/template.html",
                        controller: 'FloCtrl'
                    },
                    'container@flos': {
                        templateUrl: "views/flos/index.html"
                    }
                }

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
