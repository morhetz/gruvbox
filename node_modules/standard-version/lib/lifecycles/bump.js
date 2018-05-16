'use strict'

const chalk = require('chalk')
const checkpoint = require('../checkpoint')
const conventionalRecommendedBump = require('conventional-recommended-bump')
const figures = require('figures')
const fs = require('fs')
const DotGitignore = require('dotgitignore')
const path = require('path')
const runLifecycleScript = require('../run-lifecycle-script')
const semver = require('semver')
const writeFile = require('../write-file')

var configsToUpdate = {}

function Bump (args, pkg) {
  // reset the cache of updated config files each
  // time we perform the version bump step.
  configsToUpdate = {}

  if (args.skip.bump) return Promise.resolve()
  var newVersion = pkg.version
  return runLifecycleScript(args, 'prebump')
    .then((stdout) => {
      if (stdout && stdout.trim().length) args.releaseAs = stdout.trim()
      return bumpVersion(args.releaseAs)
    })
    .then((release) => {
      if (!args.firstRelease) {
        var releaseType = getReleaseType(args.prerelease, release.releaseType, pkg.version)
        newVersion = semver.valid(releaseType) || semver.inc(pkg.version, releaseType, args.prerelease)
        updateConfigs(args, newVersion)
      } else {
        checkpoint(args, 'skip version bump on first release', [], chalk.red(figures.cross))
      }
    })
    .then(() => {
      return runLifecycleScript(args, 'postbump')
    })
    .then(() => {
      return newVersion
    })
}

Bump.getUpdatedConfigs = function () {
  return configsToUpdate
}

function getReleaseType (prerelease, expectedReleaseType, currentVersion) {
  if (isString(prerelease)) {
    if (isInPrerelease(currentVersion)) {
      if (shouldContinuePrerelease(currentVersion, expectedReleaseType) ||
        getTypePriority(getCurrentActiveType(currentVersion)) > getTypePriority(expectedReleaseType)
      ) {
        return 'prerelease'
      }
    }

    return 'pre' + expectedReleaseType
  } else {
    return expectedReleaseType
  }
}

function isString (val) {
  return typeof val === 'string'
}

/**
 * if a version is currently in pre-release state,
 * and if it current in-pre-release type is same as expect type,
 * it should continue the pre-release with the same type
 *
 * @param version
 * @param expectType
 * @return {boolean}
 */
function shouldContinuePrerelease (version, expectType) {
  return getCurrentActiveType(version) === expectType
}

function isInPrerelease (version) {
  return Array.isArray(semver.prerelease(version))
}

var TypeList = ['major', 'minor', 'patch'].reverse()

/**
 * extract the in-pre-release type in target version
 *
 * @param version
 * @return {string}
 */
function getCurrentActiveType (version) {
  var typelist = TypeList
  for (var i = 0; i < typelist.length; i++) {
    if (semver[typelist[i]](version)) {
      return typelist[i]
    }
  }
}

/**
 * calculate the priority of release type,
 * major - 2, minor - 1, patch - 0
 *
 * @param type
 * @return {number}
 */
function getTypePriority (type) {
  return TypeList.indexOf(type)
}

function bumpVersion (releaseAs, callback) {
  return new Promise((resolve, reject) => {
    if (releaseAs) {
      return resolve({
        releaseType: releaseAs
      })
    } else {
      conventionalRecommendedBump({
        preset: 'angular'
      }, function (err, release) {
        if (err) return reject(err)
        else return resolve(release)
      })
    }
  })
}

/**
 * attempt to update the version # in a collection of common config
 * files, e.g., package.json, bower.json.
 *
 * @param args config object
 * @param newVersion version # to update to.
 * @return {string}
 */
function updateConfigs (args, newVersion) {
  const dotgit = DotGitignore()
  configsToUpdate[path.resolve(process.cwd(), './package.json')] = false
  configsToUpdate[path.resolve(process.cwd(), './package-lock.json')] = false
  configsToUpdate[path.resolve(process.cwd(), './npm-shrinkwrap.json')] = false
  configsToUpdate[path.resolve(process.cwd(), './bower.json')] = false
  Object.keys(configsToUpdate).forEach(function (configPath) {
    try {
      if (dotgit.ignore(configPath)) return
      var stat = fs.lstatSync(configPath)
      if (stat.isFile()) {
        var config = require(configPath)
        var filename = path.basename(configPath)
        checkpoint(args, 'bumping version in ' + filename + ' from %s to %s', [config.version, newVersion])
        config.version = newVersion
        writeFile(args, configPath, JSON.stringify(config, null, 2) + '\n')
        // flag any config files that we modify the version # for
        // as having been updated.
        configsToUpdate[configPath] = true
      }
    } catch (err) {
      if (err.code !== 'ENOENT') console.warn(err.message)
    }
  })
}

module.exports = Bump
