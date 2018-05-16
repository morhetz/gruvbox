'use strict';

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var _glob = require('glob');

var _glob2 = _interopRequireDefault(_glob);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

exports.default = findup;

// Before, "findup-sync" package was used,
// but it does not provide filter callback

function findup(patterns, options, fn) {
    /* jshint -W083 */

    var lastpath;
    var file;

    options = Object.create(options);
    options.maxDepth = 1;
    options.cwd = _path2.default.resolve(options.cwd);

    do {
        file = patterns.filter(function (pattern) {
            var configPath = _glob2.default.sync(pattern, options)[0];

            if (configPath) {
                return fn(_path2.default.join(options.cwd, configPath));
            }
        })[0];

        if (file) {
            return _path2.default.join(options.cwd, file);
        }

        lastpath = options.cwd;
        options.cwd = _path2.default.resolve(options.cwd, '..');
    } while (options.cwd !== lastpath);
}