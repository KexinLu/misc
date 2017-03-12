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
            this.courses.push(course);
        }
    }

    function findOneById(id) {
        return this.courses.find(function(obj) {
            return obj[Course.idPropertyName] == id
        });
    }

    CourseRepository.prototype.addCourse = addCourse;
    CourseRepository.prototype.findOneById = findOneById;
    return CourseRepository;
}());
exports.CourseRepository = CourseRepository;

var course = new Course('{"tier_eighty_five": 8, "tier_ninety": 5, "Title": "late clas poet", "Section": "001", "Detail": "", "tier_seventy_two": 10, "Other": 0, "Low": 62, "tier_sixty_four": 4, "id": 9505, "tier_sixty_eight": 5, "tier_zero": 0, "tier_seventy_six": 10, "tier_thirty": 0, "tier_fifty": 0, "Professor": "schmidt, jerry dean", "Audit": 0, "tier_g_fifty": 0, "tier_forty": 0, "Withdrew": 1, "Year": "2012", "tier_twenty": 0, "Stddev": 7.5, "Enrolled": 60, "tier_fifty_five": 0, "tier_eighty": 16, "tier_sixty": 1, "tier_ten": 0, "High": 93, "Course": "473", "Session": "w", "Pass": 59, "Fail": 0, "Avg": 78.73, "Campus": "ubc", "Subject": "chin" }');
var course1 = new Course('{"tier_eighty_five": 8, "tier_ninety": 5, "Title": "late clas poet", "Section": "001", "Detail": "", "tier_seventy_two": 10, "Other": 0, "Low": 62, "tier_sixty_four": 4, "id": 9505, "tier_sixty_eight": 5, "tier_zero": 0, "tier_seventy_six": 10, "tier_thirty": 0, "tier_fifty": 0, "Professor": "schmidt, jerry dean", "Audit": 0, "tier_g_fifty": 0, "tier_forty": 0, "Withdrew": 1, "Year": "2012", "tier_twenty": 0, "Stddev": 7.5, "Enrolled": 60, "tier_fifty_five": 0, "tier_eighty": 16, "tier_sixty": 1, "tier_ten": 0, "High": 93, "Course": "473", "Session": "w", "Pass": 59, "Fail": 0, "Avg": 78.73, "Campus": "ubc", "Subject": "chin" }');
var repo = new CourseRepository();
