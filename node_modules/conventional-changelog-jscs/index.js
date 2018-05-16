'use strict';
var Q = require('q');
var readFile = Q.denodeify(require('fs').readFile);
var resolve = require('path').resolve;

function presetOpts(cb) {
  var gitRawCommitsOpts = {
    format: '%B%n-hash-%n%H%n-gitTags-%n%d%n-committerDate-%n%ci%n-authorName-%n%an',
  };

  var parserOpts = {
    headerPattern: /^(\w*)\: (.*)$/,
    headerCorrespondence: [
      'component',
      'shortDesc'
    ]
  };

  var writerOpts = {
    transform: function(commit) {
      if (!commit.component) {
        return;
      }

      if (typeof commit.hash === 'string') {
        commit.hash = commit.hash.substring(0, 7);
      }

      return commit;
    },
    groupBy: 'component',
    commitGroupsSort: 'title',
    commitsSort: ['component', 'shortDesc']
  };

  Q.all([
    readFile(resolve(__dirname, 'templates/template.hbs'), 'utf-8'),
    readFile(resolve(__dirname, 'templates/header.hbs'), 'utf-8'),
    readFile(resolve(__dirname, 'templates/commit.hbs'), 'utf-8')
  ])
    .spread(function(template, header, commit) {
      writerOpts.mainTemplate = template;
      writerOpts.headerPartial = header;
      writerOpts.commitPartial = commit;

      cb(null, {
        gitRawCommitsOpts: gitRawCommitsOpts,
        parserOpts: parserOpts,
        writerOpts: writerOpts
      });
    });
}

module.exports = presetOpts;
