'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.gitCz = exports.commitizen = undefined;

var _commitizen = require('./parsers/commitizen');

var commitizen = _interopRequireWildcard(_commitizen);

var _gitCz = require('./parsers/git-cz');

var gitCz = _interopRequireWildcard(_gitCz);

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

exports.commitizen = commitizen;
exports.gitCz = gitCz;