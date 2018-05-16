const bump = require('../lifecycles/bump')
const checkpoint = require('../checkpoint')
const formatCommitMessage = require('../format-commit-message')
const path = require('path')
const runExec = require('../run-exec')
const runLifecycleScript = require('../run-lifecycle-script')

module.exports = function (args, newVersion) {
  if (args.skip.commit) return Promise.resolve()
  return runLifecycleScript(args, 'precommit')
    .then((message) => {
      if (message && message.length) args.message = message
      return execCommit(args, newVersion)
    })
    .then(() => {
      return runLifecycleScript(args, 'postcommit')
    })
}

function execCommit (args, newVersion) {
  var msg = 'committing %s'
  var paths = [args.infile]
  var verify = args.verify === false || args.n ? '--no-verify ' : ''
  var toAdd = ''
  // commit any of the config files that we've updated
  // the version # for.
  Object.keys(bump.getUpdatedConfigs()).forEach(function (p) {
    if (bump.getUpdatedConfigs()[p]) {
      msg += ' and %s'
      paths.unshift(path.basename(p))
      toAdd += ' ' + path.relative(process.cwd(), p)
    }
  })
  checkpoint(args, msg, paths)
  return runExec(args, 'git add' + toAdd + ' ' + args.infile)
    .then(() => {
      return runExec(args, 'git commit ' + verify + (args.sign ? '-S ' : '') + (args.commitAll ? '' : (args.infile + toAdd)) + ' -m "' + formatCommitMessage(args.message, newVersion) + '"')
    })
}
