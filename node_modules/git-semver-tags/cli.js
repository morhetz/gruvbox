#!/usr/bin/env node
'use strict'
var meow = require('meow')
var gitSemverTags = require('./')

var args = meow(`
  Usage
    git-semver-tags
  Options
    --lerna parse lerna style git tags
    --package when listing lerna style tags, filter by a package
    --tagPrefix prefix to remove from the tags during their processing`
)

gitSemverTags(function (err, tags) {
  if (err) {
    console.error(err.toString())
    process.exit(1)
  }

  console.log(tags.join('\n'))
}, {
  lernaTags: args.flags.lerna,
  package: args.flags.package,
  tagPrefix: args.flags.tagPrefix
})
