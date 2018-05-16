/* global describe it beforeEach afterEach */

'use strict'

var shell = require('shelljs')
var fs = require('fs')
var path = require('path')
var stream = require('stream')
var mockGit = require('mock-git')
var mockery = require('mockery')
var semver = require('semver')
var formatCommitMessage = require('./lib/format-commit-message')
var cli = require('./command')
var standardVersion = require('./index')

require('chai').should()

var cliPath = path.resolve(__dirname, './bin/cli.js')

function branch (branch) {
  shell.exec('git branch ' + branch)
}

function checkout (branch) {
  shell.exec('git checkout ' + branch)
}

function commit (msg) {
  shell.exec('git commit --allow-empty -m"' + msg + '"')
}

function merge (msg, branch) {
  shell.exec('git merge --no-ff -m"' + msg + '" ' + branch)
}

function execCli (argString) {
  return shell.exec('node ' + cliPath + (argString != null ? ' ' + argString : ''))
}

function execCliAsync (argString) {
  return standardVersion(cli.parse('standard-version ' + argString + ' --silent'))
}

function writePackageJson (version, option) {
  option = option || {}
  var pkg = Object.assign(option, {version: version})
  fs.writeFileSync('package.json', JSON.stringify(pkg), 'utf-8')
  delete require.cache[require.resolve(path.join(process.cwd(), 'package.json'))]
}

function writeBowerJson (version, option) {
  option = option || {}
  var bower = Object.assign(option, {version: version})
  fs.writeFileSync('bower.json', JSON.stringify(bower), 'utf-8')
}

function writeNpmShrinkwrapJson (version, option) {
  option = option || {}
  var shrinkwrap = Object.assign(option, { version: version })
  fs.writeFileSync('npm-shrinkwrap.json', JSON.stringify(shrinkwrap), 'utf-8')
}

function writePackageLockJson (version, option) {
  option = option || {}
  var pkgLock = Object.assign(option, { version: version })
  fs.writeFileSync('package-lock.json', JSON.stringify(pkgLock), 'utf-8')
}

function writeGitPreCommitHook () {
  fs.writeFileSync('.git/hooks/pre-commit', '#!/bin/sh\necho "precommit ran"\nexit 1', 'utf-8')
  fs.chmodSync('.git/hooks/pre-commit', '755')
}

function writePostBumpHook (causeError) {
  writeHook('postbump', causeError)
}

function writeHook (hookName, causeError, script) {
  shell.mkdir('-p', 'scripts')
  var content = script || 'console.error("' + hookName + ' ran")'
  content += causeError ? '\nthrow new Error("' + hookName + '-failure")' : ''
  fs.writeFileSync('scripts/' + hookName + '.js', content, 'utf-8')
  fs.chmodSync('scripts/' + hookName + '.js', '755')
}

function initInTempFolder () {
  shell.rm('-rf', 'tmp')
  shell.config.silent = true
  shell.mkdir('tmp')
  shell.cd('tmp')
  shell.exec('git init')
  commit('root-commit')
  writePackageJson('1.0.0')
}

function finishTemp () {
  shell.cd('../')
  shell.rm('-rf', 'tmp')
}

function getPackageVersion () {
  return JSON.parse(fs.readFileSync('package.json', 'utf-8')).version
}

describe('format-commit-message', function () {
  it('works for no %s', function () {
    formatCommitMessage('chore(release): 1.0.0', '1.0.0').should.equal('chore(release): 1.0.0')
  })
  it('works for one %s', function () {
    formatCommitMessage('chore(release): %s', '1.0.0').should.equal('chore(release): 1.0.0')
  })
  it('works for two %s', function () {
    formatCommitMessage('chore(release): %s \n\n* CHANGELOG: https://github.com/conventional-changelog/standard-version/blob/v%s/CHANGELOG.md', '1.0.0').should.equal('chore(release): 1.0.0 \n\n* CHANGELOG: https://github.com/conventional-changelog/standard-version/blob/v1.0.0/CHANGELOG.md')
  })
})

describe('cli', function () {
  beforeEach(initInTempFolder)
  afterEach(finishTemp)

  describe('CHANGELOG.md does not exist', function () {
    it('populates changelog with commits since last tag by default', function () {
      commit('feat: first commit')
      shell.exec('git tag -a v1.0.0 -m "my awesome first release"')
      commit('fix: patch release')

      execCli().code.should.equal(0)

      var content = fs.readFileSync('CHANGELOG.md', 'utf-8')
      content.should.match(/patch release/)
      content.should.not.match(/first commit/)
    })

    it('includes all commits if --first-release is true', function () {
      writePackageJson('1.0.1')

      commit('feat: first commit')
      commit('fix: patch release')
      execCli('--first-release').code.should.equal(0)

      var content = fs.readFileSync('CHANGELOG.md', 'utf-8')
      content.should.match(/patch release/)
      content.should.match(/first commit/)
      shell.exec('git tag').stdout.should.match(/1\.0\.1/)
    })
  })

  describe('CHANGELOG.md exists', function () {
    it('appends the new release above the last release, removing the old header', function () {
      fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

      commit('feat: first commit')
      shell.exec('git tag -a v1.0.0 -m "my awesome first release"')
      commit('fix: patch release')

      execCli().code.should.equal(0)
      var content = fs.readFileSync('CHANGELOG.md', 'utf-8')
      content.should.match(/1\.0\.1/)
      content.should.not.match(/legacy header format/)
    })

    it('commits all staged files', function () {
      fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

      commit('feat: first commit')
      shell.exec('git tag -a v1.0.0 -m "my awesome first release"')
      commit('fix: patch release')

      fs.writeFileSync('STUFF.md', 'stuff\n', 'utf-8')

      shell.exec('git add STUFF.md')

      execCli('--commit-all').code.should.equal(0)

      var content = fs.readFileSync('CHANGELOG.md', 'utf-8')
      var status = shell.exec('git status --porcelain') // see http://unix.stackexchange.com/questions/155046/determine-if-git-working-directory-is-clean-from-a-script

      status.should.equal('')
      status.should.not.match(/STUFF.md/)

      content.should.match(/1\.0\.1/)
      content.should.not.match(/legacy header format/)
    })
  })

  describe('with mocked git', function () {
    it('--sign signs the commit and tag', function () {
      // mock git with file that writes args to gitcapture.log
      return mockGit('require("fs").appendFileSync("gitcapture.log", JSON.stringify(process.argv.splice(2)) + "\\n")')
        .then(function (unmock) {
          execCli('--sign').code.should.equal(0)

          var captured = shell.cat('gitcapture.log').stdout.split('\n').map(function (line) {
            return line ? JSON.parse(line) : line
          })
          captured[captured.length - 3].should.deep.equal(['commit', '-S', 'CHANGELOG.md', 'package.json', '-m', 'chore(release): 1.0.1'])
          captured[captured.length - 2].should.deep.equal(['tag', '-s', 'v1.0.1', '-m', 'chore(release): 1.0.1'])

          unmock()
        })
    })

    it('exits with error code if git commit fails', function () {
      // mock git by throwing on attempt to commit
      return mockGit('console.error("commit yourself"); process.exit(128);', 'commit')
        .then(function (unmock) {
          var result = execCli()
          result.code.should.equal(1)
          result.stderr.should.match(/commit yourself/)

          unmock()
        })
    })

    it('exits with error code if git add fails', function () {
      // mock git by throwing on attempt to add
      return mockGit('console.error("addition is hard"); process.exit(128);', 'add')
        .then(function (unmock) {
          var result = execCli()
          result.code.should.equal(1)
          result.stderr.should.match(/addition is hard/)

          unmock()
        })
    })

    it('exits with error code if git tag fails', function () {
      // mock git by throwing on attempt to commit
      return mockGit('console.error("tag, you\'re it"); process.exit(128);', 'tag')
        .then(function (unmock) {
          var result = execCli()
          result.code.should.equal(1)
          result.stderr.should.match(/tag, you're it/)

          unmock()
        })
    })

    it('doesn\'t fail fast on stderr output from git', function () {
      // mock git by throwing on attempt to commit
      return mockGit('console.error("haha, kidding, this is just a warning"); process.exit(0);', 'add')
        .then(function (unmock) {
          writePackageJson('1.0.0')

          var result = execCli()
          result.code.should.equal(0)
          result.stderr.should.match(/haha, kidding, this is just a warning/)

          unmock()
        })
    })
  })

  describe('lifecycle scripts', () => {
    describe('prebump hook', function () {
      it('should allow prebump hook to return an alternate version #', function () {
        writePackageJson('1.0.0', {
          'standard-version': {
            'scripts': {
              'prebump': 'node scripts/prebump'
            }
          }
        })
        writeHook('prebump', false, 'console.log("9.9.9")')
        fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

        commit('feat: first commit')
        var result = execCli('--patch')
        result.stdout.should.match(/9\.9\.9/)
        result.code.should.equal(0)
      })
    })

    describe('postbump hook', function () {
      it('should run the postbump hook when provided', function () {
        writePackageJson('1.0.0', {
          'standard-version': {
            'scripts': {
              'postbump': 'node scripts/postbump'
            }
          }
        })
        writePostBumpHook()
        fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

        commit('feat: first commit')
        var result = execCli('--patch')
        result.code.should.equal(0)
        result.stderr.should.match(/postbump ran/)
      })

      it('should run the postbump and exit with error when postbump fails', function () {
        writePackageJson('1.0.0', {
          'standard-version': {
            'scripts': {
              'postbump': 'node scripts/postbump'
            }
          }
        })
        writePostBumpHook(true)
        fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

        commit('feat: first commit')
        var result = execCli('--patch')
        result.code.should.equal(1)
        result.stderr.should.match(/postbump-failure/)
      })
    })

    describe('precommit hook', function () {
      it('should run the precommit hook when provided', function () {
        writePackageJson('1.0.0', {
          'standard-version': {
            'scripts': {
              'precommit': 'node scripts/precommit'
            }
          }
        })
        writeHook('precommit')
        fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

        commit('feat: first commit')
        var result = execCli('--patch')
        result.code.should.equal(0)
        result.stderr.should.match(/precommit ran/)
      })

      it('should run the precommit hook and exit with error when precommit fails', function () {
        writePackageJson('1.0.0', {
          'standard-version': {
            'scripts': {
              'precommit': 'node scripts/precommit'
            }
          }
        })
        writeHook('precommit', true)
        fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

        commit('feat: first commit')
        var result = execCli('--patch')
        result.code.should.equal(1)
        result.stderr.should.match(/precommit-failure/)
      })

      it('should allow an alternate commit message to be provided by precommit script', function () {
        writePackageJson('1.0.0', {
          'standard-version': {
            'scripts': {
              'precommit': 'node scripts/precommit'
            }
          }
        })
        writeHook('precommit', false, 'console.log("releasing %s delivers #222")')
        fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

        commit('feat: first commit')
        var result = execCli('--patch')
        result.code.should.equal(0)
        shell.exec('git log --oneline -n1').should.match(/delivers #222/)
      })
    })
  })

  describe('pre-release', function () {
    it('works fine without specifying a tag id when prereleasing', function () {
      writePackageJson('1.0.0')
      fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

      commit('feat: first commit')
      return execCliAsync('--prerelease')
        .then(function () {
          // it's a feature commit, so it's minor type
          getPackageVersion().should.equal('1.1.0-0')
        })
    })

    it('advises use of --tag prerelease for publishing to npm', function () {
      writePackageJson('1.0.0')
      fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

      commit('feat: first commit')
      execCli('--prerelease').stdout.should.include('--tag prerelease')
    })
  })

  describe('manual-release', function () {
    it('throws error when not specifying a release type', function () {
      writePackageJson('1.0.0')
      fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

      commit('fix: first commit')
      execCli('--release-as').code.should.above(0)
    })

    describe('release-types', function () {
      var regularTypes = ['major', 'minor', 'patch']

      regularTypes.forEach(function (type) {
        it('creates a ' + type + ' release', function () {
          var originVer = '1.0.0'
          writePackageJson(originVer)
          fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

          commit('fix: first commit')

          return execCliAsync('--release-as ' + type)
            .then(function () {
              var version = {
                major: semver.major(originVer),
                minor: semver.minor(originVer),
                patch: semver.patch(originVer)
              }

              version[type] += 1

              getPackageVersion().should.equal(version.major + '.' + version.minor + '.' + version.patch)
            })
        })
      })

      // this is for pre-releases
      regularTypes.forEach(function (type) {
        it('creates a pre' + type + ' release', function () {
          var originVer = '1.0.0'
          writePackageJson(originVer)
          fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

          commit('fix: first commit')

          return execCliAsync('--release-as ' + type + ' --prerelease ' + type)
            .then(function () {
              var version = {
                major: semver.major(originVer),
                minor: semver.minor(originVer),
                patch: semver.patch(originVer)
              }

              version[type] += 1

              getPackageVersion().should.equal(version.major + '.' + version.minor + '.' + version.patch + '-' + type + '.0')
            })
        })
      })
    })

    describe('release-as-exact', function () {
      it('releases as v100.0.0', function () {
        var originVer = '1.0.0'
        writePackageJson(originVer)
        fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

        commit('fix: first commit')

        return execCliAsync('--release-as v100.0.0')
          .then(function () {
            getPackageVersion().should.equal('100.0.0')
          })
      })

      it('releases as 200.0.0-amazing', function () {
        var originVer = '1.0.0'
        writePackageJson(originVer)
        fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

        commit('fix: first commit')

        return execCliAsync('--release-as 200.0.0-amazing')
          .then(function () {
            getPackageVersion().should.equal('200.0.0-amazing')
          })
      })
    })

    it('creates a prerelease with a new minor version after two prerelease patches', function () {
      writePackageJson('1.0.0')
      fs.writeFileSync('CHANGELOG.md', 'legacy header format<a name="1.0.0">\n', 'utf-8')

      commit('fix: first patch')
      return execCliAsync('--release-as patch --prerelease dev')
        .then(function () {
          getPackageVersion().should.equal('1.0.1-dev.0')
        })

        // second
        .then(function () {
          commit('fix: second patch')
          return execCliAsync('--prerelease dev')
        })
        .then(function () {
          getPackageVersion().should.equal('1.0.1-dev.1')
        })

        // third
        .then(function () {
          commit('feat: first new feat')
          return execCliAsync('--release-as minor --prerelease dev')
        })
        .then(function () {
          getPackageVersion().should.equal('1.1.0-dev.0')
        })

        .then(function () {
          commit('fix: third patch')
          return execCliAsync('--release-as minor --prerelease dev')
        })
        .then(function () {
          getPackageVersion().should.equal('1.1.0-dev.1')
        })

        .then(function () {
          commit('fix: forth patch')
          return execCliAsync('--prerelease dev')
        })
        .then(function () {
          getPackageVersion().should.equal('1.1.0-dev.2')
        })
    })
  })

  it('handles commit messages longer than 80 characters', function () {
    commit('feat: first commit')
    shell.exec('git tag -a v1.0.0 -m "my awesome first release"')
    commit('fix: this is my fairly long commit message which is testing whether or not we allow for long commit messages')

    execCli().code.should.equal(0)

    var content = fs.readFileSync('CHANGELOG.md', 'utf-8')
    content.should.match(/this is my fairly long commit message which is testing whether or not we allow for long commit messages/)
  })

  it('formats the commit and tag messages appropriately', function () {
    commit('feat: first commit')
    shell.exec('git tag -a v1.0.0 -m "my awesome first release"')
    commit('feat: new feature!')

    execCli().code.should.equal(0)

    // check last commit message
    shell.exec('git log --oneline -n1').stdout.should.match(/chore\(release\): 1\.1\.0/)
    // check annotated tag message
    shell.exec('git tag -l -n1 v1.1.0').stdout.should.match(/chore\(release\): 1\.1\.0/)
  })

  it('appends line feed at end of package.json', function () {
    execCli().code.should.equal(0)

    var pkgJson = fs.readFileSync('package.json', 'utf-8')
    pkgJson.should.equal(['{', '  "version": "1.0.1"', '}', ''].join('\n'))
  })

  it('does not run git hooks if the --no-verify flag is passed', function () {
    writeGitPreCommitHook()

    commit('feat: first commit')
    execCli('--no-verify').code.should.equal(0)
    commit('feat: second commit')
    execCli('-n').code.should.equal(0)
  })

  it('does not print output when the --silent flag is passed', function () {
    var result = execCli('--silent')
    result.code.should.equal(0)
    result.stdout.should.equal('')
    result.stderr.should.equal('')
  })

  it('does not display `npm publish` if the package is private', function () {
    writePackageJson('1.0.0', {private: true})

    var result = execCli()
    result.code.should.equal(0)
    result.stdout.should.not.match(/npm publish/)
  })

  it('includes merge commits', function () {
    var branchName = 'new-feature'
    commit('feat: first commit')
    shell.exec('git tag -a v1.0.0 -m "my awesome first release"')
    branch(branchName)
    checkout(branchName)
    commit('Implementing new feature')
    checkout('master')
    merge('feat: new feature from branch', branchName)

    execCli().code.should.equal(0)

    var content = fs.readFileSync('CHANGELOG.md', 'utf-8')
    content.should.match(/new feature from branch/)

    var pkgJson = fs.readFileSync('package.json', 'utf-8')
    pkgJson.should.equal(['{', '  "version": "1.1.0"', '}', ''].join('\n'))
  })

  it('exits with error code if "scripts" is not an object', () => {
    writePackageJson('1.0.0', {
      'standard-version': {
        scripts: 'echo hello'
      }
    })

    commit('feat: first commit')
    var result = execCli()
    result.code.should.equal(1)
    result.stderr.should.match(/scripts must be an object/)
  })

  it('exits with error code if "skip" is not an object', () => {
    writePackageJson('1.0.0', {
      'standard-version': {
        skip: true
      }
    })

    commit('feat: first commit')
    var result = execCli()
    result.code.should.equal(1)
    result.stderr.should.match(/skip must be an object/)
  })
})

describe('standard-version', function () {
  beforeEach(initInTempFolder)
  afterEach(finishTemp)

  describe('with mocked conventionalRecommendedBump', function () {
    beforeEach(function () {
      mockery.enable({warnOnUnregistered: false, useCleanCache: true})
      mockery.registerMock('conventional-recommended-bump', function (_, cb) {
        cb(new Error('bump err'))
      })
    })

    afterEach(function () {
      mockery.deregisterMock('conventional-recommended-bump')
      mockery.disable()
    })

    it('should exit on bump error', function (done) {
      commit('feat: first commit')
      shell.exec('git tag -a v1.0.0 -m "my awesome first release"')
      commit('feat: new feature!')

      require('./index')({silent: true})
        .catch((err) => {
          err.message.should.match(/bump err/)
          done()
        })
    })
  })

  describe('with mocked conventionalChangelog', function () {
    beforeEach(function () {
      mockery.enable({warnOnUnregistered: false, useCleanCache: true})
      mockery.registerMock('conventional-changelog', function () {
        var readable = new stream.Readable({objectMode: true})
        readable._read = function () {
        }
        setImmediate(readable.emit.bind(readable), 'error', new Error('changelog err'))
        return readable
      })
    })

    afterEach(function () {
      mockery.deregisterMock('conventional-changelog')
      mockery.disable()
    })

    it('should exit on changelog error', function (done) {
      commit('feat: first commit')
      shell.exec('git tag -a v1.0.0 -m "my awesome first release"')
      commit('feat: new feature!')

      require('./index')({silent: true})
        .catch((err) => {
          err.message.should.match(/changelog err/)
          return done()
        })
    })
  })

  it('formats the commit and tag messages appropriately', function (done) {
    commit('feat: first commit')
    shell.exec('git tag -a v1.0.0 -m "my awesome first release"')
    commit('feat: new feature!')

    require('./index')({silent: true})
      .then(() => {
        // check last commit message
        shell.exec('git log --oneline -n1').stdout.should.match(/chore\(release\): 1\.1\.0/)
        // check annotated tag message
        shell.exec('git tag -l -n1 v1.1.0').stdout.should.match(/chore\(release\): 1\.1\.0/)
        done()
      })
  })

  describe('bower.json support', function () {
    beforeEach(function () {
      writeBowerJson('1.0.0')
    })

    it('bumps version # in bower.json', function () {
      commit('feat: first commit')
      shell.exec('git tag -a v1.0.0 -m "my awesome first release"')
      commit('feat: new feature!')
      return require('./index')({silent: true})
        .then(() => {
          JSON.parse(fs.readFileSync('bower.json', 'utf-8')).version.should.equal('1.1.0')
          getPackageVersion().should.equal('1.1.0')
        })
    })
  })

  describe('npm-shrinkwrap.json support', function () {
    beforeEach(function () {
      writeNpmShrinkwrapJson('1.0.0')
    })

    it('bumps version # in npm-shrinkwrap.json', function (done) {
      commit('feat: first commit')
      shell.exec('git tag -a v1.0.0 -m "my awesome first release"')
      commit('feat: new feature!')
      require('./index')({silent: true})
        .then(() => {
          JSON.parse(fs.readFileSync('npm-shrinkwrap.json', 'utf-8')).version.should.equal('1.1.0')
          getPackageVersion().should.equal('1.1.0')
          return done()
        })
    })
  })

  describe('package-lock.json support', function () {
    beforeEach(function () {
      writePackageLockJson('1.0.0')
      fs.writeFileSync('.gitignore', '', 'utf-8')
    })

    it('bumps version # in package-lock.json', function () {
      commit('feat: first commit')
      shell.exec('git tag -a v1.0.0 -m "my awesome first release"')
      commit('feat: new feature!')
      return require('./index')({silent: true})
        .then(() => {
          JSON.parse(fs.readFileSync('package-lock.json', 'utf-8')).version.should.equal('1.1.0')
          getPackageVersion().should.equal('1.1.0')
        })
    })
  })

  describe('dry-run', function () {
    it('skips all non-idempotent steps', function (done) {
      commit('feat: first commit')
      shell.exec('git tag -a v1.0.0 -m "my awesome first release"')
      commit('feat: new feature!')
      execCli('--dry-run').stdout.should.match(/### Features/)
      shell.exec('git log --oneline -n1').stdout.should.match(/feat: new feature!/)
      shell.exec('git tag').stdout.should.match(/1\.0\.0/)
      getPackageVersion().should.equal('1.0.0')
      return done()
    })
  })

  describe('skip', () => {
    it('allows bump and changelog generation to be skipped', function () {
      let changelogContent = 'legacy header format<a name="1.0.0">\n'
      writePackageJson('1.0.0')
      fs.writeFileSync('CHANGELOG.md', changelogContent, 'utf-8')

      commit('feat: first commit')
      return execCliAsync('--skip.bump true --skip.changelog true')
        .then(function () {
          getPackageVersion().should.equal('1.0.0')
          var content = fs.readFileSync('CHANGELOG.md', 'utf-8')
          content.should.equal(changelogContent)
        })
    })

    it('allows the commit phase to be skipped', function () {
      let changelogContent = 'legacy header format<a name="1.0.0">\n'
      writePackageJson('1.0.0')
      fs.writeFileSync('CHANGELOG.md', changelogContent, 'utf-8')

      commit('feat: new feature from branch')
      return execCliAsync('--skip.commit true')
        .then(function () {
          getPackageVersion().should.equal('1.1.0')
          var content = fs.readFileSync('CHANGELOG.md', 'utf-8')
          content.should.match(/new feature from branch/)
          // check last commit message
          shell.exec('git log --oneline -n1').stdout.should.match(/feat: new feature from branch/)
        })
    })
  })

  describe('.gitignore', () => {
    beforeEach(function () {
      writeBowerJson('1.0.0')
    })

    it('does not update files present in .gitignore', () => {
      fs.writeFileSync('.gitignore', 'bower.json', 'utf-8')

      commit('feat: first commit')
      shell.exec('git tag -a v1.0.0 -m "my awesome first release"')
      commit('feat: new feature!')
      return require('./index')({silent: true})
        .then(() => {
          JSON.parse(fs.readFileSync('bower.json', 'utf-8')).version.should.equal('1.0.0')
          getPackageVersion().should.equal('1.1.0')
        })
    })
  })
})
