"use strict";
let _Course = require("../Model/Course");
let Course = _Course.Course;

var CourseRepository = (function () {
    function CourseRepository() {
        let self = this;
        this.courses = new Array();
    }

    function addCourse(course) {
        if (this.findOneById(course[Course.idPropertyName]) == null) {
            console.log( "Adding course " + course.courses_dept + course.courses_id + ' uuid : ' + course.courses_uuid);
            this.courses.push(course);
        }
    }

    function findOneById(id) {
        return this.courses.find(function(obj) {
            return obj[Course.idPropertyName] == id
        });
    }

    function courseExist(id) {
        let c = findOneById(id);
        return (c != null || c != undefined);
    }

    function removeCourse(course) {
        this.courses.remove(course);
    }

    CourseRepository.prototype.addCourse = addCourse;
    CourseRepository.prototype.removeCourse = removeCourse;
    CourseRepository.prototype.findOneById = findOneById;
    CourseRepository.prototype.courseExist = courseExist;

    return CourseRepository;
}());
exports.CourseRepository = CourseRepository;
