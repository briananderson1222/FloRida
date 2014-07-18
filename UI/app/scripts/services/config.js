/**
 * Created by briananderson on 7/18/14.
 */
angular.module('floRidaApp')
    .config(['$httpProvider', function ($httpProvider) {
        $httpProvider.interceptors.push(['$q', '$injector', function ($q, $injector) {
            return {
                'request': function (config) {
                    console.log("request", config);
                    return config || $q.when(config);
                },
                'requestError': function (rejection) {
                    console.log("requestError", rejection);
                    return $q.reject(rejection);
                },
                'response': function (response) {
                    console.log("response", response);
                    return response || $q.when(response);
                },
                'responseError': function (rejection) {
                    console.log("responseError", rejection);
                    return $q.reject(rejection);
                }
            };
        }]);
    }]);