'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.commit = undefined;

var _os = require('os');

var _os2 = _interopRequireDefault(_os);

var _child_process = require('child_process');

var _dedent = require('dedent');

var _dedent2 = _interopRequireDefault(_dedent);

var _util = require('../common/util');

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

exports.commit = commit;

/**
 * Asynchronously git commit at a given path with a message
 */

function commit(sh, repoPath, message, options, done) {
  var called = false;
  var args = ['commit', '-m', (0, _dedent2.default)(message)].concat(_toConsumableArray(options.args || []));
  var child = (0, _child_process.spawn)('git', args, {
    cwd: repoPath,
    stdio: options.quiet ? 'ignore' : 'inherit'
  });

  child.on('error', function (err) {
    if (called) return;
    called = true;

    done(err);
  });

  child.on('exit', function (code, signal) {
    if (called) return;
    called = true;

    if (code) {
      done(Object.assign(new Error('git exited with error code ' + code), { code: code, signal: signal }));
    } else {
      done(null);
    }
  });
}