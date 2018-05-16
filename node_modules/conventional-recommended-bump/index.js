'use strict';
var concat = require('concat-stream');
var conventionalCommitsFilter = require('conventional-commits-filter');
var conventionalCommitsParser = require('conventional-commits-parser');
var gitSemverTags = require('git-semver-tags');
var gitRawCommits = require('git-raw-commits');
var objectAssign = require('object-assign');

var VERSIONS = ['major', 'minor', 'patch'];

function conventionalRecommendedBump(options, parserOpts, cb) {
  var config;
  var noop = function() {};

  if (typeof options !== 'object') {
    throw new TypeError('options must be an object');
  }

  if (typeof parserOpts === 'function') {
    cb = parserOpts;
  } else {
    cb = cb || noop;
  }

  options = objectAssign({
    ignoreReverted: true,
    warn: function() {}
  }, options);

  if (options.preset) {
    try {
      config = require('./presets/' + options.preset);
    } catch (err) {
      cb(new Error('Preset: "' + options.preset + '" does not exist'));
      return;
    }
  } else {
    config = options.config || {};
  }

  var whatBump = options.whatBump || config.whatBump || noop;
  parserOpts = objectAssign({}, config.parserOpts, parserOpts);
  parserOpts.warn = parserOpts.warn || options.warn;

  gitSemverTags(function(err, tags) {
    if (err) {
      cb(err);
      return;
    }

    gitRawCommits({
      format: '%B%n-hash-%n%H',
      from: tags[0] || '',
      path: options.path
    })
      .pipe(conventionalCommitsParser(parserOpts))
      .pipe(concat(function(data) {
        var commits;

        if (options.ignoreReverted) {
          commits = conventionalCommitsFilter(data);
        } else {
          commits = data;
        }

        if (!commits || !commits.length) {
          options.warn('No commits since last release');
        }

        var result = whatBump(commits);

        if (typeof result === 'number') {
          result = {
            level: result
          };
        }

        if (result && result.level != null) {
          result.releaseType = VERSIONS[result.level];
        } else if (result == null) {
          result = {};
        }

        cb(null, result);
      }));
  }, {lernaTags: !!options.lernaPackage, package: options.lernaPackage, tagPrefix: options.tagPrefix});
}

module.exports = conventionalRecommendedBump;
