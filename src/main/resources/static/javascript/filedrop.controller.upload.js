function UploadJsController($scope, Upload, $window) {
    $scope.init = function(maxUploadSize, downloadKey) {
        $scope.files = [];
        $scope.uploadSize = 0;
        $scope.maxUploadSize = maxUploadSize;
        $scope.downloadKey = downloadKey;
        console.log($scope.downloadKey);
    };

    $scope.submit = function() {
        if ($scope.files && $scope.files.length) {
            var count = $scope.files.length;
            for (var i = 0; i < $scope.files.length; i++) {
                Upload.upload({
                    url: "/filedrop/prepare/files",
                    data: {
                        comment: $scope.files[i].comment,
                        file: $scope.files[i]
                    },
                    arrayKey: ""
                })
                      .then(function() {
                          count--;

                          if (count === 0) {
                              $window.location.href = "/filedrop/download/" + $scope.downloadKey;
                          }
                      });
            }
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

filedropApp.controller("UploadJsController", UploadJsController);