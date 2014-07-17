/**
 * Created by briananderson on 7/17/14.
 */
'use strict';

angular.module('floRidaApp')
    .controller('AppCtrl', ['$scope', '$state', function ($scope, $state) {

        $scope.navigateTo = function (state) {
            $state.go(state);
        };

    }]);