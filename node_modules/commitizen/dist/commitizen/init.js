'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var _configLoader = require('./configLoader');

var configLoader = _interopRequireWildcard(_configLoader);

var _util = require('../common/util');

var _adapter = require('./adapter');

var adapter = _interopRequireWildcard(_adapter);

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var addPathToAdapterConfig = adapter.addPathToAdapterConfig,
    generateNpmInstallAdapterCommand = adapter.generateNpmInstallAdapterCommand,
    getNpmInstallStringMappings = adapter.getNpmInstallStringMappings;
exports.default = init;


var CLI_PATH = _path2.default.normalize(__dirname + '/../../');

/**
 * CZ INIT
 * 
 * Init is generally responsible for initializing an adapter in
 * a user's project. The goal is to be able to run 
 * `commitizen init` and be prompted for certain fields which
 * will help you install the proper adapter for your project.
 * 
 * Init does not actually create the adapter (it defers to adapter
 * for this). Instead, it is specifically designed to help gather
 * and validate the information needed to install the adapter
 * properly without interfering with a previous adapter config.
 */

/**
 * The defaults for init
 */
var defaultInitOptions = {
  save: false,
  saveDev: true,
  saveExact: false,
  force: false
};

/**
 * Runs npm install for the adapter then modifies the config.commitizen as needed
 */
function init(sh, repoPath, adapterNpmName) {
  var _ref = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : defaultInitOptions,
      _ref$save = _ref.save,
      save = _ref$save === undefined ? false : _ref$save,
      _ref$saveDev = _ref.saveDev,
      saveDev = _ref$saveDev === undefined ? true : _ref$saveDev,
      _ref$saveExact = _ref.saveExact,
      saveExact = _ref$saveExact === undefined ? false : _ref$saveExact,
      _ref$force = _ref.force,
      force = _ref$force === undefined ? false : _ref$force;

  // Don't let things move forward if required args are missing
  checkRequiredArguments(sh, repoPath, adapterNpmName);

  // Move to the correct directory so we can run commands
  sh.cd(repoPath);

  // Load the current adapter config
  var adapterConfig = loadAdapterConfig();

  // Get the npm string mappings based on the arguments provided
  var stringMappings = getNpmInstallStringMappings(save, saveDev, saveExact, force);

  // Generate a string that represents the npm install command
  var installAdapterCommand = generateNpmInstallAdapterCommand(stringMappings, adapterNpmName);

  // Check for previously installed adapters
  if (adapterConfig && adapterConfig.path && adapterConfig.path.length > 0) {

    // console.log(`
    //   Previous adapter detected! 
    // `);

    if (!force) {

      // console.log(`
      //   Previous adapter detected! 
      // `);

      throw 'A previous adapter is already configured. Use --force to override';
    } else {
      // Override it
      try {
        (0, _util.executeShellCommand)(sh, repoPath, installAdapterCommand);
        addPathToAdapterConfig(sh, CLI_PATH, repoPath, adapterNpmName);
      } catch (e) {
        console.error(e);
      }
    }
  } else {

    // console.log(`
    //   No previous adapter was detected 
    // `); 

    try {

      (0, _util.executeShellCommand)(sh, repoPath, installAdapterCommand);
      addPathToAdapterConfig(sh, CLI_PATH, repoPath, adapterNpmName);
    } catch (e) {
      console.error(e);
    }
  }
}

/**
 * Checks to make sure that the required arguments are passed
 * Throws an exception if any are not.
 */
function checkRequiredArguments(sh, path, adapterNpmName) {
  if (!sh) {
    throw "You must pass an instance of shelljs when running init.";
  }
  if (!path) {
    throw "Path is required when running init.";
  }
  if (!adapterNpmName) {
    throw "The adapter's npm name is required when running init.";
  }
}

/**
 * CONFIG
 * Loads and returns the adapter config at key config.commitizen, if it exists
 */
function loadAdapterConfig() {
  var config = configLoader.load();
  if (config) {
    return config;
  } else {
    return;
  }
}