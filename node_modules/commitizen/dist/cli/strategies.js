'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.gitCz = exports.git = undefined;

var _git = require('./strategies/git');

var _git2 = _interopRequireDefault(_git);

var _gitCz = require('./strategies/git-cz');

var _gitCz2 = _interopRequireDefault(_gitCz);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

exports.git = _git2.default;
exports.gitCz = _gitCz2.default;