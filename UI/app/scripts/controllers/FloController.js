'use strict';

angular.module('floRidaApp')
    .controller('FloCtrl', ['$scope', '$modal', 'FloService', 'FloAPI', function ($scope, $modal, FloService, FloAPI) {

        $scope.scratches = [
            { key: 'BaseURL', value: 'https://' }
        ];

        $scope.addScratch = function() {
            $scope.scratches.unshift({key:'',value:''});
        };

        var getNode = function() {
            return {
                child_nodes: []
            };
        };

        var getActionNode = function(status, type, action) {
            var node = getNode();
            node.status = status;
            node.type = type;
            node.action = action;
        };

        var getEndpointNode = function(url, requestMethod, headers, parameters, body) {
            var node = getNode();
            node.url = url;
            node.request_method = requestMethod;
            node.headers = headers;
            node.parameters = parameters;
            node.body = body;
        };

        $scope.addEndpoint = function() {
            var modalInstance = $modal.open({
                controller:'addEndPointController',
                templateUrl: 'views/flos/addEndpoint.html'
            });
            modalInstance.result.then();
        };

        $scope.addAction = function() {
            var modalInstance = $modal.open({
                templateUrl: 'views/flos/flosAddAction.html'
            });
            modalInstance.result.then();
        };

        $scope.getNodes = function() {
            FloAPI.getNodes(function(data) {
                $scope.nodesHierarchy = data;
            });
        };

        //Initialization
        $scope.getNodes();
    }])

    .controller('addEndPointController', function ($scope, $modalInstance) {
        $scope.addEndPoint = {};
        $scope.addEndPoint.headers = [{key:'',value:''}];

        $scope.addHeader = function() {
            $scope.addEndPoint.headers.unshift({key:'',value:''});
        };
        $scope.addEndPoint.parameters = [{key:'',value:''}];

        $scope.addParameter = function() {
            $scope.addEndPoint.parameters.unshift({key:'',value:''});
        };
        $scope.saveEndPoint = function() {
            $modalInstance.close($scope.addEndPoint);
        }
    })

    .controller('FloAddActionCtrl', function ($scope) {
        $scope.saveClicked = function() {
            console.log("Button Clicked")
        };
    });
