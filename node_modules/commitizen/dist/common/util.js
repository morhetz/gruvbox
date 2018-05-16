'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.isInTest = exports.isString = exports.isFunction = exports.isArray = exports.getParsedPackageJsonFromPath = exports.getParsedJsonFromFile = exports.executeShellCommand = undefined;

var _fs = require('fs');

var _fs2 = _interopRequireDefault(_fs);

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

exports.executeShellCommand = executeShellCommand;
exports.getParsedJsonFromFile = getParsedJsonFromFile;
exports.getParsedPackageJsonFromPath = getParsedPackageJsonFromPath;
exports.isArray = isArray;
exports.isFunction = isFunction;
exports.isString = isString;
exports.isInTest = isInTest;

/**
 * Executes the command passed to it at the path requested
 * using the instance of shelljs passed in
 */

function executeShellCommand(sh, path, installCommand) {
  sh.cd(path);
  sh.exec(installCommand);
}

/**
 * Gets the parsed contents of a json file
 */
function getParsedJsonFromFile(filePath, fileName) {
  var encoding = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : 'utf8';

  try {
    var packageJsonContents = _fs2.default.readFileSync(_path2.default.join(filePath, fileName), encoding);
    return JSON.parse(packageJsonContents);
  } catch (e) {
    console.error(e);
  }
}

/**
 * A helper method for getting the contents of package.json at a given path
 */
function getParsedPackageJsonFromPath(path) {
  return getParsedJsonFromFile(path, 'package.json');
}

/**
 * Test if the passed argument is an array
 */
function isArray(arr) {
  if (typeof arr === "undefined") {
    return false;
  } else if (arr === null) {
    return false;
  } else {
    return arr.constructor === Array;
  }
}

/**
 * Test if the passed argument is a function
 */
function isFunction(functionToCheck) {
  if (typeof functionToCheck === "undefined") {
    return false;
  } else if (functionToCheck === null) {
    return false;
  } else {
    var getType = {};
    return functionToCheck && getType.toString.call(functionToCheck) === '[object Function]';
  }
}

/**
 * Test if the passed argument is a string
 */
function isString(str) {
  if (typeof str === "undefined") {
    return false;
  } else if (str === null) {
    return false;
  } else {
    return Object.prototype.toString.call(str) === '[object String]';
  }
}

function isInTest() {
  return typeof global.it === 'function';
}