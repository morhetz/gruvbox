'use strict';

var path = require('path');
var oshomedir = require('os-homedir');
var Promise = require('pinkie-promise');
var minimist = require('minimist');
var assign = require('object-assign');
var loadPackageProp = require('./lib/loadPackageProp');
var loadRc = require('./lib/loadRc');
var loadJs = require('./lib/loadJs');
var loadDefinedFile = require('./lib/loadDefinedFile');

var parsedCliArgs = minimist(process.argv);

module.exports = function(moduleName, options) {
  options = assign({
    packageProp: moduleName,
    rc: '.' + moduleName + 'rc',
    js: moduleName + '.config.js',
    argv: 'config',
    rcStrictJson: false,
    stopDir: oshomedir(),
  }, options);

  if (options.argv && parsedCliArgs[options.argv]) {
    options.configPath = path.resolve(parsedCliArgs[options.argv]);
  }

  var splitSearchPath = splitPath(options.cwd);

  if (options.configPath) {
    return loadDefinedFile(options.configPath, options.format);
  }

  function find() {
    var currentSearchPath = joinPath(splitSearchPath);

    return Promise.resolve().then(function() {
      if (!options.packageProp) return;
      return loadPackageProp(currentSearchPath, options.packageProp);
    }).then(function(result) {
      if (result || !options.rc) return result;
      return loadRc(path.join(currentSearchPath, options.rc), {
        strictJson: options.rcStrictJson,
        extensions: options.rcExtensions,
      });
    }).then(function(result) {
      if (result || !options.js) return result;
      return loadJs(path.join(currentSearchPath, options.js));
    }).then(function(result) {
      if (result) return result;
      // Notice the mutation of splitSearchPath
      if (currentSearchPath === options.stopDir || !splitSearchPath.pop()) {
        return null;
      }
      return find();
    });
  }

  return find();
};

function splitPath(x) {
  return path.resolve(x || '').split(path.sep);
}

function joinPath(parts) {
  return parts.join(path.sep);
}
