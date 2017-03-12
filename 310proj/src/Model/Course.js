"use strict";
var Course = (function () {
    let internalKeyToExternalKeyMap = [
        '{"property": "courses_dept",       "key": "Subject"   , "type": "string" }', //string
        '{"property": "courses_id",         "key": "Course"    , "type": "string" }',//string; The course number (will be treated as a string (e.g., 499b)).
        '{"property": "courses_avg",        "key": "Avg"       , "type": "number" }',//number; The average of the course offering.
        '{"property": "courses_instructor", "key": "Professor" , "type": "string" }', //string; The instructor teaching the course offering.
        '{"property": "courses_title",      "key": "Title"     , "type": "string" }',  //string; The name of the course.
        '{"property": "courses_pass",       "key": "Pass"      , "type": "number" }', //number; The number of students that passed the course offering.
        '{"property": "courses_fail",       "key": "Fail"      , "type": "number" }',//number; The number of students that failed the course offering.
        '{"property": "courses_audit",      "key": "Audit"     , "type": "number" }', //number; The number of students that audited the course offering.
        '{"property": "courses_uuid",       "key": "id"        , "type": "string" }'
    ];

    let idPropertyName = "courses_uuid";

    function Course(json) {
        let self = this;
        let data = (typeof json == 'object') ? json : JSON.parse(json);

        doForAllProperties(function(name, type, key) {
            let value = data[key];
            self[name] = value;
        })
    }

    function jsonSerialize(columns) {
        let self = this;
        let object = {};

        doForAllProperties(function(property, type, key) {
            if (
                columns == null ||
                columns.includes(property)
            ) {
                object[property] = self[property];
            }
        })
        return JSON.stringify(object);
    }

    function doForAllProperties(callback) {
        for (let i = 0; i < internalKeyToExternalKeyMap.length;  i++) {
            let propertyKeyObject = JSON.parse(internalKeyToExternalKeyMap[i]);
            let propertyName = propertyKeyObject.property;
            let propertyType = propertyKeyObject.type;
            let matchingKey = propertyKeyObject.key;

            callback(propertyName, propertyType, matchingKey);
        }
    }

    Course.prototype.jsonSerialize = jsonSerialize;
    Course.idPropertyName = idPropertyName;

    return Course;
}());
exports.Course = Course;
exports.Course.idPropertyName = Course.idPropertyName;

