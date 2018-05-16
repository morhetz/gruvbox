'use strict'

var conventionalChangelogCore = require('conventional-changelog-core')
var conventionalChangelogPresetLoader = require('conventional-changelog-preset-loader')

function conventionalChangelog (options, context, gitRawCommitsOpts, parserOpts, writerOpts) {
  options.warn = options.warn || function () {}

  if (options.preset) {
    try {
      options.config = conventionalChangelogPresetLoader(options.preset.toLowerCase())
    } catch (err) {
      options.warn('Preset: "' + options.preset + '" does not exist')
    }
  }

  return conventionalChangelogCore(options, context, gitRawCommitsOpts, parserOpts, writerOpts)
}

module.exports = conventionalChangelog
