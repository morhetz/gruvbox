'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _fs = require('fs');

var _fs2 = _interopRequireDefault(_fs);

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var _pathExists = require('path-exists');

var _stripJsonComments = require('strip-json-comments');

var _stripJsonComments2 = _interopRequireDefault(_stripJsonComments);

var _configLoader = require('../configLoader');

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

exports.default = getConfigContent;

/**
 * Read the content of a configuration file
 * - if not js or json: strip any comments
 * - if js or json: require it
 * @param {String} configPath - full path to configuration file
 * @return {Object}
 */

function readConfigContent(configPath) {
  var parsedPath = _path2.default.parse(configPath);
  var isRcFile = parsedPath.ext !== '.js' && parsedPath.ext !== '.json';
  var jsonString = _fs2.default.readFileSync(configPath, 'utf-8');
  var parse = isRcFile ? function (contents) {
    return JSON.parse((0, _stripJsonComments2.default)(contents));
  } : function (contents) {
    return JSON.parse(contents);
  };

  try {
    var parsed = parse(jsonString);

    Object.defineProperty(parsed, 'configPath', {
      value: configPath
    });

    return parsed;
  } catch (error) {
    error.message = ['Parsing JSON at ' + configPath + ' for commitizen config failed:', error.mesasge].join('\n');

    throw error;
  }
}

/**
 * Get content of the configuration file
 * @param {String} configPath - partial path to configuration file
 * @param {String} directory - directory path which will be joined with config argument
 * @return {Object}
 */
function getConfigContent(configPath, baseDirectory) {
  if (!configPath) {
    return;
  }

  var resolvedPath = _path2.default.resolve(baseDirectory, configPath);
  var configBasename = _path2.default.basename(resolvedPath);

  if (!(0, _pathExists.sync)(resolvedPath)) {
    return (0, _configLoader.getNormalizedConfig)(resolvedPath);
  }

  var content = readConfigContent(resolvedPath);
  return (0, _configLoader.getNormalizedConfig)(configBasename, content);
};