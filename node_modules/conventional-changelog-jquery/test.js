'use strict';
var conventionalChangelogCore = require('conventional-changelog-core');
var config = require('./');
var expect = require('chai').expect;
var shell = require('shelljs');
var through = require('through2');
var writeFileSync = require('fs').writeFileSync;

describe('jquery preset', function() {
  before(function() {
    shell.config.silent = true;
    shell.rm('-rf', 'tmp');
    shell.mkdir('tmp');
    shell.cd('tmp');
    shell.mkdir('git-templates');
    shell.exec('git init --template=./git-templates');

    writeFileSync('test1', '');
    shell.exec('git add --all && git commit -m"Core: Make jQuery objects iterable"');
    writeFileSync('test2', '');
    shell.exec('git add --all && git commit -m"CSS: Don\'t name the anonymous swap function"');
    writeFileSync('test3', '');
    shell.exec('git add --all && git commit -m"Event: Remove an internal argument to the on method"');
    writeFileSync('test4', '');
    shell.exec('git add --all && git commit -m"Manipulation: Remove an internal argument to the remove method"');
    writeFileSync('test5', '');
    shell.exec('git add --all && git commit -m"Bad commit"');
  });

  it('should work if there is no semver tag', function(done) {
    conventionalChangelogCore({
      config: config
    })
      .on('error', function(err) {
        done(err);
      })
      .pipe(through(function(chunk) {
        chunk = chunk.toString();

        expect(chunk).to.include('Make jQuery objects iterable');
        expect(chunk).to.include('### CSS');
        expect(chunk).to.include('Remove an internal argument to the on method');
        expect(chunk).to.include('### Manipulation');

        expect(chunk).to.not.include('Bad');

        done();
      }));
  });
});
