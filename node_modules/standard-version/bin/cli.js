#!/usr/bin/env node
var standardVersion = require('../index')
var cmdParser = require('../command')

/* istanbul ignore if */
if (process.version.match(/v(\d+)\./)[1] < 4) {
  console.error('standard-version: Node v4 or greater is required. `standard-version` did not run.')
} else {
  standardVersion(cmdParser.argv)
    .catch(() => {
      process.exit(1)
    })
}
