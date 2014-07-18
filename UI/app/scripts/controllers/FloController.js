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

        $scope.runFlo = function() {
            FloAPI.runFlo(FloService.id);
        };

        $scope.addFlo = function() {
            var modalInstance = $modal.open({
                controller: 'AddFloModalCtrl',
                templateUrl: 'views/flos/partials/modal_add_flo.html',
                resolve: {
                    flo: function() {
                        return FloService;
                    }
                }
            });
            modalInstance.result.then(function(flo) {
                $scope.flo.name = flo.name;
                $scope.navigateTo('flos.add');
            });
        };

        $scope.addEndpoint = function(node) {
            var modalInstance = $modal.open({
                controller:'addEndPointController',
                templateUrl: 'views/flos/addEndpoint.html'
            });
            modalInstance.result.then(function(endpointNode) {
                endpointNode.flow_id = FloService.id;
                endpointNode.parent_id = node.id;
                endpointNode.node_type = 'endpoint';
                FloAPI.addNode(endpointNode, function(data) {
                    $scope.nodesHierarchy = data;
                });
            });
        };

        $scope.addAction = function(node) {
            var modalInstance = $modal.open({
                controller:'FloAddActionCtrl',
                templateUrl: 'views/flos/flosAddAction.html'
            });
            modalInstance.result.then(function(actionNode) {
                actionNode.flow_id = FloService.id;
                actionNode.parent_id = node.id;
                actionNode.node_type = 'action';
                actionNode.type = 'text'; //TODO; hardcoded for now
                FloAPI.addNode(actionNode, function(data) {
                    $scope.nodesHierarchy = data;
                });
            });
        };

        $scope.deleteNode = function(node) {
            FloAPI.removeNode(node.flow_id, node.id, function(data) {
                $scope.nodesHierarchy = data;
            });
        };

        $scope.getNodes = function() {
            FloAPI.getNode(FloService.id, function(data) {
                $scope.nodesHierarchy = data;
            });
        };

        $scope.templateForNode = function(node) {
          return "views/flos/partials/"+ node.node_type +"Node.html"
        };

        //Initialization
        $scope.flo = FloService;
        $scope.flo.id = 'phdhhfxqfxxjbbzmzemfrpsqriulkuishtmxkxnxqvuhhijoal';
        $scope.getNodes();
    }])

    .controller('AddFloModalCtrl', ['$scope', '$modalInstance', 'flo', function($scope, $modalInstance, flo) {
        $scope.flo = flo;
        $scope.save = function(flo) {
            $modalInstance.close(flo)
        };
    }])
    .controller('addEndPointController', function ($scope, $modalInstance) {
        $scope.addEndPoint = {};
        $scope.request_methods = [
            {key:'GET', value:'GET'},
            {key:'POST', value:'POST'}
        ];
        $scope.addEndPoint.request_method = $scope.request_methods[0];

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

    .controller('FloAddActionCtrl', function ($scope, $modalInstance) {
        $scope.addActionModel = {};
        $scope.saveClicked = function() {
            $modalInstance.close($scope.addActionModel);
        };
    });
