'use strict'

var exec = require('child_process').exec
var semverValid = require('semver').valid
var regex = /tag:\s*(.+?)[,)]/gi
var cmd = 'git log --decorate --no-color'

function lernaTag (tag, pkg) {
  if (pkg && !(new RegExp('^' + pkg + '@')).test(tag)) {
    return false
  } else {
    return /^.+@[0-9]+\.[0-9]+\.[0-9]+(-.+)?$/.test(tag)
  }
}

module.exports = function (callback, opts) {
  opts = opts || {}

  if (opts.package && !opts.lernaTags) {
    callback(Error('opts.package should only be used when running in lerna mode'))
    return
  }

  exec(cmd, {
    maxBuffer: Infinity
  }, function (err, data) {
    if (err) {
      callback(err)
      return
    }

    var tags = []
    var tagPrefixRegexp
    if (opts.tagPrefix) {
      tagPrefixRegexp = new RegExp('^' + opts.tagPrefix + '(.*)')
    }
    data.split('\n').forEach(function (decorations) {
      var match
      while ((match = regex.exec(decorations))) {
        var tag = match[1]
        if (opts.lernaTags) {
          if (lernaTag(tag, opts.package)) {
            tags.push(tag)
          }
        } else if (opts.tagPrefix) {
          var matches = tag.match(tagPrefixRegexp)
          if (matches && semverValid(matches[1])) {
            tags.push(tag)
          }
        } else if (semverValid(tag)) {
          tags.push(tag)
        }
      }
    })

    callback(null, tags)
  })
}
