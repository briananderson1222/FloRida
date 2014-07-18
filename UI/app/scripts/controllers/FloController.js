'use strict';

angular.module('floRidaApp')
  .controller('FloCtrl', function ($scope) {

        $scope.scratches = [
            { key: 'BaseURL', value: 'https://' }
        ];

        $scope.addScratch = function() {
          $scope.scratches.unshift({key:'',value:''});
        };
  })
  .controller('addEndPointController', function ($scope) {
        $scope.headers = [{key:'',value:''}];

        $scope.addHeader = function() {
            $scope.headers.unshift({key:'',value:''});
        };
        $scope.parameters = [{key:'',value:''}];

        $scope.addParameter = function() {
            $scope.parameters.unshift({key:'',value:''});
        };
    });
