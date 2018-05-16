'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.addPath = addPath;

/**
 * Synchronously adds a path to git staging
 */

function addPath(sh, repoPath) {
  sh.cd(repoPath);
  sh.exec('git add .');
}