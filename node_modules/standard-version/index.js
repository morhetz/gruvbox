const path = require('path')
const printError = require('./lib/print-error')

const bump = require('./lib/lifecycles/bump')
const changelog = require('./lib/lifecycles/changelog')
const commit = require('./lib/lifecycles/commit')
const tag = require('./lib/lifecycles/tag')

module.exports = function standardVersion (argv) {
  var pkgPath = path.resolve(process.cwd(), './package.json')
  var pkg = require(pkgPath)
  var newVersion = pkg.version
  var defaults = require('./defaults')
  var args = Object.assign({}, defaults, argv)

  return Promise.resolve()
    .then(() => {
      return bump(args, pkg)
    })
    .then((_newVersion) => {
      // if bump runs, it calculaes the new version that we
      // should release at.
      if (_newVersion) newVersion = _newVersion
      return changelog(args, newVersion)
    })
    .then(() => {
      return commit(args, newVersion)
    })
    .then(() => {
      return tag(newVersion, pkg.private, args)
    })
    .catch((err) => {
      printError(args, err.message)
      throw err
    })
}
