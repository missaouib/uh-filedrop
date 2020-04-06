function UploadHelpdeskJsController($scope, Upload, $window) {
    $scope.init = function() {
        $scope.files = [];
        $scope.uploadSize = 0;
        $scope.maxUploadSize = $window.maxUploadSize;
        $scope.uploadKey = $window.uploadKey;
        $scope.expiration = $window.expiration;
        $scope.ticketNumber = $window.ticketNumber;
    };

    $scope.submit = function() {
        if ($scope.files && $scope.files.length) {
            let count = 0;
            $scope.files.map((file) => {
                Upload.upload({
                    url: "/filedrop/helpdesk/files/" + $scope.uploadKey,
                    data: {
                        comment: file.comment,
                        file
                    },
                    arrayKey: ""
                })
                      .then(() => {
                          count++;
                          if (count === $scope.files.length) {
                              $window.location.href = "/filedrop/helpdesk/successful/" + $scope.uploadKey + "?expiration=" + $scope.expiration + "&ticketNumber=" + $scope.ticketNumber;
                          }
                      });
            });
        }
    };

    $scope.addFiles = function(files) {
        $scope.files = $scope.files.concat(files);
        angular.forEach(files, function(file) {
            file.comment = "";
            $scope.uploadSize += file.size;
        });
    };

    $scope.removeFile = function(file) {
        var index = $scope.files.indexOf(file);
        if (index > -1) {
            $scope.files.splice(index, 1);
            $scope.uploadSize -= file.size;
        }
    };

    $scope.isUploadLarge = function() {
        return $scope.uploadSize > $scope.maxUploadSize;
    };
}

filedropApp.controller("UploadHelpdeskJsController", UploadHelpdeskJsController);