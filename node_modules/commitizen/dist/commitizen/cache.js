'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.setCacheValueSync = exports.readCacheSync = exports.getCacheValueSync = undefined;

var _fs = require('fs');

var _fs2 = _interopRequireDefault(_fs);

var _lodash = require('lodash');

var _lodash2 = _interopRequireDefault(_lodash);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

exports.getCacheValueSync = getCacheValueSync;
exports.readCacheSync = readCacheSync;
exports.setCacheValueSync = setCacheValueSync;

/**
 * Reads the entire cache
 */

function readCacheSync(cachePath) {
  return JSON.parse(_fs2.default.readFileSync(cachePath, 'utf8'));
}

/**
 * Sets a cache value and writes the file to disk
 */
function setCacheValueSync(cachePath, key, value) {
  var originalCache;
  try {
    originalCache = readCacheSync(cachePath);
  } catch (e) {
    originalCache = {};
  }
  var newCache = _lodash2.default.assign(originalCache, _defineProperty({}, key, value));
  _fs2.default.writeFileSync(cachePath, JSON.stringify(newCache, null, '  '));
  return newCache;
}

/**
 * Gets a single value from the cache given a key
 */
function getCacheValueSync(cachePath, repoPath) {
  try {
    var cache = readCacheSync(cachePath);
    return cache[repoPath];
  } catch (e) {
    return;
  }
}