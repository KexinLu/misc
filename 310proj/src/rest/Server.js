"use strict";
var restify = require("restify");
var Util_1 = require("../Util");
var Course = require("../Model/Course").Course;
var EntityManager = require("../EntityManager").EntityManager;
var Server = (function () {
    var entityManager;
    function Server(port) {
        Util_1.default.info("Server::<init>( " + port + " )");
        this.port = port;

        entityManager = new EntityManager();
        entityManager.setUpRepos();
    }
    Server.prototype.stop = function () {
        Util_1.default.info('Server::close()');
        var that = this;
        return new Promise(function (fulfill) {
            that.rest.close(function () {
                fulfill(true);
            });
        });
    };
    Server.prototype.start = function () {
        var that = this;
        return new Promise(function (fulfill, reject) {
            try {
                Util_1.default.info('Server::start() - start');
                that.rest = restify.createServer({
                    name: 'insightUBC'
                });
                that.rest.get('/', function (req, res, next) {
                    res.send(200);
                    return next();
                });
                that.rest.get('/echo/:msg', Server.echo);
                that.rest.get('/class/:id', getCourseAction);
                that.rest.post('/class',  postCourseActino);
                //that.rest.del('/class/:id', deleteCourseAction);
                //that.rest.put('/class/:id', putClassAction);

                that.rest.listen(that.port, function () {
                    Util_1.default.info('Server::start() - restify listening: ' + that.rest.url);
                    fulfill(true);
                });
                that.rest.on('error', function (err) {
                    Util_1.default.info('Server::start() - restify ERROR: ' + err);
                    reject(err);
                });
            }
            catch (err) {
                Util_1.default.error('Server::start() - ERROR: ' + err);
                reject(err);
            }
        });
    };

    function getCourseAction(req, res, next) {
        try {
            let id = req.params.id;
            let result = performGetCourse(id);
            Util_1.default.info('Server::course(..) - responding ' + result.code);
            res.json(result.code, result.body);
        }
        catch (err) {
            Util_1.default.error('Server::course(..) - responding 400');
            res.json(400, { error: err.message });
        }
        return next();
    }

    function performGetCourse(id) {
        let c = entityManager.courseRepository.findOneById(id);
        if (c == {}) {
            return { code: 403, body: { message: 'could not find course with id ' + id }};
        }

        return { code: 200, body: { message: c}};
    };

    function postCourseActino(req, res, next) {
        try {
            console.log(Object.getOwnPropertyNames(req.params));
            let json = req.params.json;
            let result = performPostCourseAction(json);
            Util_1.default.info('Server::course(..) - responding ' + result.code);
            res.json(result.code, result.body);
        }
        catch (err) {
            Util_1.default.error('Server::course(..) - responding 400');
            res.json(400, { error: err.message });
        }
        return next();
    };

    function performPostCourseAction(json) {
        let course = new Course(json);
        let repo = entityManager.courseRepository;
        if (repo.courseExist(course)) {
            return {code: 400, body: {message: "failed to create, course with id " + course.courses_uuid + " already exist"}};
        }
        repo.addCourse(course);

        return {code: 200, body: {message: "succeeded"}};
    }

    //function deleteCourseActino(req, res, next) {
    //};

    //function updateCourseAction(req, res, next) {
    //};

    Server.echo = function (req, res, next) {
        Util_1.default.trace('Server::echo(..) - params: ' + JSON.stringify(req.params));
        try {
            var result = Server.performEcho(req.params.msg);
            Util_1.default.info('Server::echo(..) - responding ' + result.code);
            res.json(result.code, result.body);
        }
        catch (err) {
            Util_1.default.error('Server::echo(..) - responding 400');
            res.json(400, { error: err.message });
        }
        return next();
    };

    Server.performEcho = function (msg) {
        if (typeof msg !== 'undefined' && msg !== null) {
            return { code: 200, body: { message: msg + '...' + msg } };
        }
        else {
            return { code: 400, body: { error: 'Message not provided' } };
        }
    };
    return Server;
}());
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = Server;
//# sourceMappingURL=Server.js.map
