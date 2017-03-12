"use strict";
let Course = require("./Model/Course").Course;
let CourseRepository = require("./Repository/CourseRepository").CourseRepository;

let fs = require("fs");
let JSZip = require("jszip");
var EntityManager = (function () {
    function EntityManager(courseRepository) {
    }

    function setUpRepos() {
        this.courseRepository = new CourseRepository();
        this.getRecordsFromZip(__dirname + "/../datafixture/courses.zip", Course);
    }

    function getRecordsFromZip(path, targetClass = Course) {
        let self = this;
        let repo = this.courseRepository;
        let dataPromise = new JSZip.external.Promise(function (resolve, reject) {
            fs.readFile(path, function(err, data) {
                if (err) {
                    reject(err);
                } else {
                    resolve(data);
                }
            });
        }).then(
            function (data) {
                return JSZip.loadAsync(data);
            },
            function (err) {
                console.log("Failed loading data " + err);
            }
        ).then(
            function(data) {
                data.forEach(
                    function(relativePath, file) {
                        //console.log('loading ' + relativePath);
                        let fileContent = file.async("text")
                        .then(
                            function(txt) {
                                let results = [];
                                if (txt != '') {
                                    results = JSON.parse(txt).result;
                                }
                                for (let i = 0; i < results.length ; i++) {
                                    self.courseRepository.addCourse(new targetClass(results[i]));
                                }
                            },
                            function (err) {
                                console.log("unable to retrive data from " + relativePath + " file content: " + txt);
                            }
                        );
                    }
                );
            },
            function(err) {
                console.log(err);
            }
        );
    }

    EntityManager.prototype.getRecordsFromZip = getRecordsFromZip;
    EntityManager.prototype.setUpRepos = setUpRepos;

    return EntityManager;
}());
exports.EntityManager = EntityManager;
