'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.init = init;

/**
 * Synchronously creates a new git repo at a path
 */

function init(sh, repoPath) {
  sh.cd(repoPath);
  sh.exec('git init');
}