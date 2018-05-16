'use strict';

var fs = require('graceful-fs');
var Promise = require('pinkie-promise');
var yaml = require('js-yaml');
var parseJson = require('parse-json');
var requireFromString = require('require-from-string');

module.exports = function(filepath, expectedFormat) {
  return new Promise(function(resolve, reject) {
    fs.readFile(filepath, 'utf8', function(fileError, content) {
      if (fileError) return reject(fileError);
      resolve(content);
    });
  }).then(function(content) {
    var parsedConfig = (function() {
      switch (expectedFormat) {
        case 'json':
          return parseJson(content, filepath);
        case 'yaml':
          return yaml.safeLoad(content, {
            filename: filepath,
          });
        case 'js':
          return requireFromString(content, filepath);
        default:
          return tryAllParsing(content, filepath);
      }
    })();

    if (!parsedConfig) {
      throw new Error(
        'Failed to parse "' + filepath + '" as JSON, JS, or YAML.'
      );
    }

    return {
      config: parsedConfig,
      filepath: filepath,
    };
  });
};

function tryAllParsing(content, filepath) {
  return tryYaml(content, filepath, function() {
    return tryRequire(content, filepath, function() {
      return null;
    });
  });
}

function tryYaml(content, filepath, cb) {
  try {
    var result = yaml.safeLoad(content, {
      filename: filepath,
    });
    if (typeof result === 'string') {
      return cb();
    }
    return result;
  } catch (e) {
    return cb();
  }
}

function tryRequire(content, filepath, cb) {
  try {
    return requireFromString(content, filepath);
  } catch (e) {
    return cb();
  }
}
