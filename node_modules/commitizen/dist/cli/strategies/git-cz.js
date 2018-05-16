'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _fs = require('fs');

var _fs2 = _interopRequireDefault(_fs);

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var _shelljs = require('shelljs');

var _shelljs2 = _interopRequireDefault(_shelljs);

var _inquirer = require('inquirer');

var _inquirer2 = _interopRequireDefault(_inquirer);

var _findRoot = require('find-root');

var _findRoot2 = _interopRequireDefault(_findRoot);

var _util = require('../../common/util');

var _parsers = require('../parsers');

var _commitizen = require('../../commitizen');

var _git = require('../../git');

var _git2 = require('./git');

var gitStrategy = _interopRequireWildcard(_git2);

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

// destructure for shorter apis
var parse = _parsers.gitCz.parse;
var getPrompter = _commitizen.adapter.getPrompter,
    resolveAdapterPath = _commitizen.adapter.resolveAdapterPath;
var isClean = _commitizen.staging.isClean;
exports.default = gitCz;


function gitCz(rawGitArgs, environment, adapterConfig) {

  // See if any override conditions exist.

  // In these very specific scenarios we may want to use a different
  // commit strategy than git-cz. For example, in the case of --amend
  var parsedCommitizenArgs = _parsers.commitizen.parse(rawGitArgs);

  if (parsedCommitizenArgs.a) {
    // console.log('override -a in place');
    (0, _git.addPath)(_shelljs2.default, process.cwd());
  }

  if (parsedCommitizenArgs.amend) {
    // console.log('override --amend in place');
    gitStrategy.default(rawGitArgs, environment);
    return;
  }

  // Now, if we've made it past overrides, proceed with the git-cz strategy
  var parsedGitCzArgs = parse(rawGitArgs);

  // Determine if we need to process this commit as a retry instead of a
  // normal commit.
  var retryLastCommit = rawGitArgs && rawGitArgs[0] === '--retry';

  var resolvedAdapterConfigPath = resolveAdapterPath(adapterConfig.path);
  var resolvedAdapterRootPath = (0, _findRoot2.default)(resolvedAdapterConfigPath);
  var prompter = getPrompter(adapterConfig.path);

  isClean(process.cwd(), function (error, stagingIsClean) {
    if (error) {
      throw error;
    }

    if (stagingIsClean) {
      throw new Error('No files added to staging! Did you forget to run git add?');
    }

    // OH GOD IM SORRY FOR THIS SECTION
    var adapterPackageJson = (0, _util.getParsedPackageJsonFromPath)(resolvedAdapterRootPath);
    var cliPackageJson = (0, _util.getParsedPackageJsonFromPath)(environment.cliPath);
    console.log('cz-cli@' + cliPackageJson.version + ', ' + adapterPackageJson.name + '@' + adapterPackageJson.version + '\n');
    (0, _commitizen.commit)(_shelljs2.default, _inquirer2.default, process.cwd(), prompter, {
      args: parsedGitCzArgs,
      disableAppendPaths: true,
      emitData: true,
      quiet: false,
      retryLastCommit: retryLastCommit
    }, function (error) {
      if (error) {
        throw error;
      }
    });
  });
}