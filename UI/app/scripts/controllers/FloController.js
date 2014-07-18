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
  .controller('MyController', function ($scope) {
    $scope.headers = [{"key":'',"value":''}]
  })
.controller('FloAddActionCtrl', function ($scope) {

});
