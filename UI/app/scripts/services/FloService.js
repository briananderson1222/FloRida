/**
 * Created by briananderson on 7/18/14.
 */
'use strict';

angular.module('floRidaApp')
    .service('FloService', function() {
        var flo = {
            id: '',
            name: '',
            scratch_paper: [],
            initial_node: {
                childNodes: []
            }
        };
        return flo;
    })
    .service('FloAPI', ['$http', '$q', function($http, $q) {

        var requestTimeout = function (customTimeout) {
            var time = (customTimeout) ? customTimeout : 30000;
            return time; //$q.defer()
        };

        var makeServiceRequest = function (method, url, dynamicUrlParams, params, successCallback, errorCallback) {
            // Allow passing of an object for mapping URLs similarly to angular's $resource
            if (dynamicUrlParams) {
                var i, urlParams = Object.keys(dynamicUrlParams);
                for (i in urlParams) {
                    if (urlParams[i]) {
                        var key = urlParams[i];
                        url = url.replace(":" + key, dynamicUrlParams[key]);
                    }
                }
            }
            var deferredAbort = requestTimeout();
            var httpConfig = {
                method: method,
                url: url,
                timeout: deferredAbort.promise
            };
            switch (method.toLowerCase()) {
                case "get":
                    httpConfig.params = params;
                    break;
                default:
                case "post":
                    httpConfig.data = params;
                    break;
            }
            var request = $http(httpConfig);
            var promise = request.then(function (response) {
                return response.data;
            }, function () {
                return $q.reject("Something went wrong");
            });
            promise.abort = function () {
                deferredAbort.resolve();
            };
            promise.finally(
                function () {
                    promise.abort = angular.noop;
                    deferredAbort = request = promise = null;
                }
            );
            return promise.then(successCallback, errorCallback);
        };

        var baseUrl = 'http://192.168.0.80:4567/';

        var runFlo = function(nodeId, successCallback, errorCallback) {
            return makeServiceRequest("GET", baseUrl+"flowmodel-run/:nodeId", {nodeId : nodeId}, null, successCallback, errorCallback);
        };

        var getNode = function(nodeId, successCallback, errorCallback) {
            return makeServiceRequest("GET", baseUrl+"flowmodel-flat/:nodeId", {nodeId : nodeId}, null, successCallback, errorCallback);
        };

        var addNode = function(node, successCallback, errorCallback) {
            return makeServiceRequest("GET", baseUrl+"flowmodel-append", null, node, successCallback, errorCallback);
        };

        var removeNode = function(floId, nodeId, successCallback, errorCallback) {
            var params = {
                flow_id: floId,
                child_id: nodeId
            };
            return makeServiceRequest("DELETE", baseUrl+"flowmodel-delete", null, params, successCallback, errorCallback);
        };

        return {
            runFlo: runFlo,
            getNode: getNode,
            addNode: addNode,
            removeNode: removeNode
        }
    }]);
;