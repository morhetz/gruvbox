'use strict'

var gitRawCommits = require('git-raw-commits')
var conventionalCommitsParser = require('conventional-commits-parser')
var conventionalChangelogWriter = require('conventional-changelog-writer')
var stream = require('stream')
var through = require('through2')
var mergeConfig = require('./lib/merge-config')

function conventionalChangelog (options, context, gitRawCommitsOpts, parserOpts, writerOpts) {
  writerOpts = writerOpts || {}

  var readable = new stream.Readable({
    objectMode: writerOpts.includeDetails
  })
  readable._read = function () {}

  mergeConfig(options, context, gitRawCommitsOpts, parserOpts, writerOpts)
    .then(function (data) {
      options = data.options
      context = data.context
      gitRawCommitsOpts = data.gitRawCommitsOpts
      parserOpts = data.parserOpts
      writerOpts = data.writerOpts

      gitRawCommits(gitRawCommitsOpts)
        .on('error', function (err) {
          err.message = 'Error in git-raw-commits: ' + err.message
          setImmediate(readable.emit.bind(readable), 'error', err)
        })
        .pipe(conventionalCommitsParser(parserOpts))
        .on('error', function (err) {
          err.message = 'Error in conventional-commits-parser: ' + err.message
          setImmediate(readable.emit.bind(readable), 'error', err)
        })
        // it would be better if `gitRawCommits` could spit out better formatted data
        // so we don't need to transform here
        .pipe(through.obj(function (chunk, enc, cb) {
          try {
            options.transform.call(this, chunk, cb)
          } catch (err) {
            cb(err)
          }
        }))
        .on('error', function (err) {
          err.message = 'Error in options.transform: ' + err.message
          setImmediate(readable.emit.bind(readable), 'error', err)
        })
        .pipe(conventionalChangelogWriter(context, writerOpts))
        .on('error', function (err) {
          err.message = 'Error in conventional-changelog-writer: ' + err.message
          setImmediate(readable.emit.bind(readable), 'error', err)
        })
        .pipe(through({
          objectMode: writerOpts.includeDetails
        }, function (chunk, enc, cb) {
          try {
            readable.push(chunk)
          } catch (err) {
            setImmediate(function () {
              throw err
            })
          }

          cb()
        }, function (cb) {
          readable.push(null)

          cb()
        }))
    })
    .catch(function (err) {
      setImmediate(readable.emit.bind(readable), 'error', err)
    })

  return readable
}

module.exports = conventionalChangelog
