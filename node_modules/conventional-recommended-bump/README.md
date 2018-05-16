#  [![NPM version][npm-image]][npm-url] [![Build Status][travis-image]][travis-url] [![Dependency Status][daviddm-image]][daviddm-url] [![Coverage Status][coverall-image]][coverall-url]

> Get a recommended version bump based on conventional commits

Got the idea from https://github.com/conventional-changelog/conventional-changelog/pull/29


## Install

```sh
$ npm install --save conventional-recommended-bump
```


## Usage

```js
var conventionalRecommendedBump = require('conventional-recommended-bump');

conventionalRecommendedBump({
  preset: 'angular'
}, function(err, result) {
  console.log(result.releaseType);
  //=> 'major'
});
```

```sh
$ npm install --global conventional-recommended-bump
$ conventional-recommended-bump --help
```


## API

### conventionalRecommendedBump(options, [parserOpts], [callback])

#### options

##### ignoreReverted

Type: `boolean` Default: `true`

If `true`, reverted commits will be ignored.

##### preset

Type: `string` Possible values: `'angular'`

It's recommended to use a preset so you don't have to define everything yourself. Presets are names of built-in `config`.

##### config

Type: `object`

This should serve as default values for other arguments of `conventionalRecommendedBump` so you don't need to rewrite the same or similar config across your projects. Any value in this could be overwritten.

**NOTE:** `options.config` will be overwritten by the values of preset. You should use either `preset` or `config`, but not both.

##### whatBump

Type: `function`

A function that takes parsed commits as argument.

This should return an object including but not limited to `level` and `reason`. `level` is a `number` indicating what bump it should be and `reason` is the reason of such release.

For backward compatibility, it could return a `number` indicating what bump it should be.

###### whatBump(commits)

####### commits

Type: `array`

An array of parsed commits. The commits are from last semver tag to `HEAD` and is parsed by [conventional-commits-parser](https://github.com/conventional-changelog/conventional-commits-parser).

If it returns with `level` `0` it will be a `major` bump. If `1`, `minor` bump. If `2`, `patch`.

##### tagPrefix

Type: `string`

Specify a prefix for the git tag that will be taken into account during the comparison.

For instance if your version tag is prefixed by `version/` instead of `v` you would specify `--tagPrefix=version/`


#### parserOpts

See the [conventional-commits-parser](https://github.com/conventional-changelog/conventional-commits-parser) docs.

#### callback

Type: `function`

##### callback(error, object)

###### object

Object includes what's returned by `whatBump` and

####### releaseType

Type: `string` Possible values: `'major'`, `'minor'` and `'patch'`

The value of what it should release as.

## Related

- [conventional-github-releaser](https://github.com/conventional-changelog/conventional-github-releaser) - Make a new GitHub release from git metadata
- [conventional-changelog](https://github.com/conventional-changelog/conventional-changelog/tree/master/packages/conventional-changelog-cli) - Generate a changelog from git metadata
- [conventional-commits-detector](https://github.com/conventional-changelog/conventional-commits-detector) - Detect what commit message convention your repository is using
- [semantic-release](https://github.com/semantic-release/semantic-release) - fully automated package publishing


## License

MIT © [Steve Mao](https://github.com/stevemao)


[npm-image]: https://badge.fury.io/js/conventional-recommended-bump.svg
[npm-url]: https://npmjs.org/package/conventional-recommended-bump
[travis-image]: https://travis-ci.org/conventional-changelog/conventional-recommended-bump.svg?branch=master
[travis-url]: https://travis-ci.org/conventional-changelog/conventional-recommended-bump
[daviddm-image]: https://david-dm.org/conventional-changelog/conventional-recommended-bump.svg?theme=shields.io
[daviddm-url]: https://david-dm.org/conventional-changelog/conventional-recommended-bump
[coverall-image]: https://coveralls.io/repos/conventional-changelog/conventional-recommended-bump/badge.svg
[coverall-url]: https://coveralls.io/r/conventional-changelog/conventional-recommended-bump
