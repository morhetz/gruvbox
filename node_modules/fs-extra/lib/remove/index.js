var rimraf = require('./rimraf')

function removeSync (dir) {
  return rimraf.sync(dir, {disableGlob: true})
}

function remove (dir, callback) {
  var options = {disableGlob: true}
  return callback ? rimraf(dir, options, callback) : rimraf(dir, options, function () {})
}

module.exports = {
  remove: remove,
  removeSync: removeSync
}
