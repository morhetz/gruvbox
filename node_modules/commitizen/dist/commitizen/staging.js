'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.isClean = undefined;

var _child_process = require('child_process');

exports.isClean = isClean;

/**
 * Asynchrounously determines if the staging area is clean
 */

function isClean(repoPath, done) {
  (0, _child_process.exec)('git diff --cached --name-only', {
    maxBuffer: Infinity,
    cwd: repoPath || process.cwd()
  }, function (error, stdout) {
    if (error) {
      return done(error);
    }
    var output = stdout || '';
    done(null, output.trim().length === 0);
  });
}