'use strict';
var Q = require('q');
var readFile = Q.denodeify(require('fs').readFile);
var resolve = require('path').resolve;

function presetOpts(cb) {
  var parserOpts = {
    headerPattern: /^(\w*)\: (.*)$/,
    headerCorrespondence: [
      'component',
      'shortDesc'
    ]
  };

  var writerOpts = {
    transform: function(commit) {
      var componentLength;

      if (!commit.component || typeof commit.component !== 'string') {
        return;
      }

      commit.component = commit.component.substring(0, 72);
      componentLength = commit.component.length;

      if (typeof commit.hash === 'string') {
        commit.hash = commit.hash.substring(0, 7);
      }

      if (typeof commit.shortDesc === 'string') {
        commit.shortDesc = commit.shortDesc.substring(0, 72 - componentLength);
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
        parserOpts: parserOpts,
        writerOpts: writerOpts
      });
    });
}

module.exports = presetOpts;
