'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.load = undefined;

var _configLoader = require('../configLoader');

exports.load = load;

// Configuration sources in priority order.

var configs = ['package.json', '.czrc', '.cz.json'];

function load(config, cwd) {
  return (0, _configLoader.loader)(configs, config, cwd);
}