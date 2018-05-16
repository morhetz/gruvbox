'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.log = exports.init = exports.commit = exports.addPath = undefined;

var _add = require('./git/add');

var _commit = require('./git/commit');

var _init = require('./git/init');

var _log = require('./git/log');

exports.addPath = _add.addPath;
exports.commit = _commit.commit;
exports.init = _init.init;
exports.log = _log.log;