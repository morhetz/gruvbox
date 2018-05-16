'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var _dedent = require('dedent');

var _dedent2 = _interopRequireDefault(_dedent);

var _cachedir = require('cachedir');

var _cachedir2 = _interopRequireDefault(_cachedir);

var _fsExtra = require('fs-extra');

var _git = require('../git');

var _cache = require('./cache');

var cache = _interopRequireWildcard(_cache);

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

exports.default = commit;

/**
 * Takes all of the final inputs needed in order to make dispatch a git commit
 */

function dispatchGitCommit(sh, repoPath, template, options, overrideOptions, done) {
  // Commit the user input -- side effect that we'll test
  (0, _git.commit)(sh, repoPath, template, _extends({}, options, overrideOptions), function (error) {
    done(error, template);
  });
}

/**
 * Asynchronously commits files using commitizen
 */
function commit(sh, inquirer, repoPath, prompter, options, done) {
  var cacheDirectory = (0, _cachedir2.default)('commitizen');
  var cachePath = _path2.default.join(cacheDirectory, 'commitizen.json');

  (0, _fsExtra.ensureDir)(cacheDirectory, function (error) {
    if (error) {
      console.error("Couldn't create commitizen cache directory: ", error);
      // TODO: properly handle error?
    } else {
      if (options.retryLastCommit) {

        console.log('Retrying last commit attempt.');

        // We want to use the last commit instead of the current commit,
        // so lets override some options using the values from cache.

        var _cache$getCacheValueS = cache.getCacheValueSync(cachePath, repoPath),
            retryOptions = _cache$getCacheValueS.options,
            retryOverrideOptions = _cache$getCacheValueS.overrideOptions,
            retryTemplate = _cache$getCacheValueS.template;

        dispatchGitCommit(sh, repoPath, retryTemplate, retryOptions, retryOverrideOptions, done);
      } else {
        // Get user input -- side effect that is hard to test
        prompter(inquirer, function (error, template, overrideOptions) {
          // Allow adapters to error out
          // (error: Error?, template: String, overrideOptions: Object)
          if (!(error instanceof Error)) {
            overrideOptions = template;
            template = error;
            error = null;
          }

          if (error) {
            return done(error);
          }

          // We don't want to add retries to the cache, only actual commands
          cache.setCacheValueSync(cachePath, repoPath, { template: template, options: options, overrideOptions: overrideOptions });
          dispatchGitCommit(sh, repoPath, template, options, overrideOptions, done);
        });
      }
    }
  });
}