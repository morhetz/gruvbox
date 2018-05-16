// MIT License
// Bradley Meck
// https://github.com/bmeck/dotignore
var minimatch = require('minimatch')
var path = require('path')

function IgnoreMatcher (str) {
  var negated = this.negated = []
  var rooted = this.rooted = []
  this.matchers = (str.split(/\r?\n|\r/)).map(function (line) {
    var negatedLine = line[0] === '!'
    var commentLine = line[0] === '#'
    var rootedLine = line[0] === '/'
    if (negatedLine || commentLine || rootedLine) {
      line = line.substring(1)
    }
    var emptyLine = line === ''
    if (emptyLine) {
      return null
    }
    var isShellGlob = line.indexOf('/') >= 0
    negated[negated.length] = negatedLine
    rooted[rooted.length] = rootedLine || isShellGlob
    return minimatch.makeRe(line, {
      comment: commentLine,
      empty: emptyLine,
      matchBase: !rootedLine,
      negated: true // negated
    })
  }).filter(Boolean)
  return this
}
IgnoreMatcher.prototype.delimiter = path.sep
IgnoreMatcher.prototype.shouldIgnore = function (filename) {
  var isMatching = false
  for (var i = 0; i < this.matchers.length; i++) {
    var matcher = this.matchers[i]
    if (this.rooted[i]) {
      if (matcher.test(filename)) {
        isMatching = !this.negated[i]
      }
    } else if (filename.split(this.delimiter).some(function (part) {
      return matcher.test(part)
    })) {
      isMatching = !this.negated[i]
    }
  }
  return isMatching
}
exports.createMatcher = function (ignoreFileStr) {
  return new IgnoreMatcher(ignoreFileStr)
}
