'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.resolveAdapterPath = exports.generateNpmInstallAdapterCommand = exports.getPrompter = exports.getNpmInstallStringMappings = exports.getNearestProjectRootDirectory = exports.getNearestNodeModulesDirectory = exports.addPathToAdapterConfig = undefined;

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var _fs = require('fs');

var _fs2 = _interopRequireDefault(_fs);

var _findNodeModules = require('find-node-modules');

var _findNodeModules2 = _interopRequireDefault(_findNodeModules);

var _lodash = require('lodash');

var _lodash2 = _interopRequireDefault(_lodash);

var _detectIndent = require('detect-indent');

var _detectIndent2 = _interopRequireDefault(_detectIndent);

var _shelljs = require('shelljs');

var _shelljs2 = _interopRequireDefault(_shelljs);

var _util = require('../common/util');

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

exports.addPathToAdapterConfig = addPathToAdapterConfig;
exports.getNearestNodeModulesDirectory = getNearestNodeModulesDirectory;
exports.getNearestProjectRootDirectory = getNearestProjectRootDirectory;
exports.getNpmInstallStringMappings = getNpmInstallStringMappings;
exports.getPrompter = getPrompter;
exports.generateNpmInstallAdapterCommand = generateNpmInstallAdapterCommand;
exports.resolveAdapterPath = resolveAdapterPath;

/**
 * ADAPTER
 *
 * Adapter is generally responsible for actually installing adapters to an
 * end user's project. It does not perform checks to determine if there is
 * a previous commitizen adapter installed or if the proper fields were
 * provided. It defers that responsibility to init.
 */

/**
 * Modifies the package.json, sets config.commitizen.path to the path of the adapter
 * Must be passed an absolute path to the cli's root
 */

function addPathToAdapterConfig(sh, cliPath, repoPath, adapterNpmName) {

  var commitizenAdapterConfig = {
    config: {
      commitizen: {
        path: './node_modules/' + adapterNpmName
      }
    }
  };

  var packageJsonPath = _path2.default.join(getNearestProjectRootDirectory(), 'package.json');
  var packageJsonString = _fs2.default.readFileSync(packageJsonPath, 'utf-8');
  // tries to detect the indentation and falls back to a default if it can't
  var indent = (0, _detectIndent2.default)(packageJsonString).indent || '  ';
  var packageJsonContent = JSON.parse(packageJsonString);
  var newPackageJsonContent = '';
  if (_lodash2.default.get(packageJsonContent, 'config.commitizen.path') !== adapterNpmName) {
    newPackageJsonContent = _lodash2.default.merge(packageJsonContent, commitizenAdapterConfig);
  }
  _fs2.default.writeFileSync(packageJsonPath, JSON.stringify(newPackageJsonContent, null, indent) + '\n');
}

/**
 * Generates an npm install command given a map of strings and a package name
 */
function generateNpmInstallAdapterCommand(stringMappings, adapterNpmName) {

  // Start with an initial npm install command
  var installAdapterCommand = 'npm install ' + adapterNpmName;

  // Append the neccesary arguments to it based on user preferences
  var _iteratorNormalCompletion = true;
  var _didIteratorError = false;
  var _iteratorError = undefined;

  try {
    for (var _iterator = stringMappings.entries()[Symbol.iterator](), _step; !(_iteratorNormalCompletion = (_step = _iterator.next()).done); _iteratorNormalCompletion = true) {
      var _step$value = _slicedToArray(_step.value, 2),
          key = _step$value[0],
          value = _step$value[1];

      if (value) {
        installAdapterCommand = installAdapterCommand + ' ' + value;
      }
    }
  } catch (err) {
    _didIteratorError = true;
    _iteratorError = err;
  } finally {
    try {
      if (!_iteratorNormalCompletion && _iterator.return) {
        _iterator.return();
      }
    } finally {
      if (_didIteratorError) {
        throw _iteratorError;
      }
    }
  }

  return installAdapterCommand;
}

/**
 * Gets the nearest npm_modules directory
 */
function getNearestNodeModulesDirectory(options) {

  // Get the nearest node_modules directories to the current working directory
  var nodeModulesDirectories = (0, _findNodeModules2.default)(options);

  // Make sure we find a node_modules folder

  /* istanbul ignore else */
  if (nodeModulesDirectories && nodeModulesDirectories.length > 0) {
    return nodeModulesDirectories[0];
  } else {
    console.error('Error: Could not locate node_modules in your project\'s root directory. Did you forget to npm init or npm install?');
  }
}

/**
 * Gets the nearest project root directory
 */
function getNearestProjectRootDirectory(options) {
  return _path2.default.join(process.cwd(), getNearestNodeModulesDirectory(options), '/../');
}

/**
 * Gets a map of arguments where the value is the corresponding npm strings
 */
function getNpmInstallStringMappings(save, saveDev, saveExact, force) {
  return new Map().set('save', save && !saveDev ? '--save' : undefined).set('saveDev', saveDev ? '--save-dev' : undefined).set('saveExact', saveExact ? '--save-exact' : undefined).set('force', force ? '--force' : undefined);
}

/**
 * Gets the prompter from an adapter given an adapter path
 */
function getPrompter(adapterPath) {
  // Resolve the adapter path
  var resolvedAdapterPath = resolveAdapterPath(adapterPath);

  // Load the adapter
  var adapter = require(resolvedAdapterPath);

  /* istanbul ignore next */
  if (adapter && adapter.prompter && (0, _util.isFunction)(adapter.prompter)) {
    return adapter.prompter;
  } else if (adapter && adapter.default && adapter.default.prompter && (0, _util.isFunction)(adapter.default.prompter)) {
    return adapter.default.prompter;
  } else {
    throw "Could not find prompter method in the provided adapter module: " + adapterPath;
  }
}

/**
 * Given a resolvable module name or path, which can be a directory or file, will
 * return a located adapter path or will throw.
 */
function resolveAdapterPath(inboundAdapterPath) {
  // Check if inboundAdapterPath is a path or node module name
  var parsed = _path2.default.parse(inboundAdapterPath);
  var isPath = parsed.dir.length > 0 && parsed.dir.charAt(0) !== "@";

  // Resolve from the root of the git repo if inboundAdapterPath is a path
  var absoluteAdapterPath = isPath ? _path2.default.resolve(getGitRootPath(), inboundAdapterPath) : inboundAdapterPath;

  try {
    // try to resolve the given path
    return require.resolve(absoluteAdapterPath);
  } catch (error) {
    error.message = "Could not resolve " + absoluteAdapterPath + ". " + error.message;
    throw error;
  }
}

function getGitRootPath() {
  return _shelljs2.default.exec('git rev-parse --show-toplevel').stdout.trim();
}