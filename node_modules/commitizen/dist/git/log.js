'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.log = undefined;

var _child_process = require('child_process');

exports.log = log;

/**
 * Asynchronously gets the git log output
 */

function log(repoPath, done) {
  (0, _child_process.exec)('git log', {
    maxBuffer: Infinity,
    cwd: repoPath
  }, function (error, stdout, stderr) {
    if (error) {
      throw error;
    }
    done(stdout);
  });
}