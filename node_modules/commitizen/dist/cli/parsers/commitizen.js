'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.parse = undefined;

var _minimist = require('minimist');

var _minimist2 = _interopRequireDefault(_minimist);

var _util = require('../../common/util');

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

exports.parse = parse;

/**
 * Takes args, parses with minimist and some ugly vudoo, returns output
 * 
 * TODO: Aww shit this is ugly. Rewrite with mega leet tests plz, kthnx.
 */

function parse(rawGitArgs) {

  var args = (0, _minimist2.default)(rawGitArgs, {
    boolean: true
  });

  return args;
}