# cosmiconfig

[![Build Status](https://img.shields.io/travis/davidtheclark/cosmiconfig/master.svg?label=unix%20build)](https://travis-ci.org/davidtheclark/cosmiconfig) [![Build status](https://img.shields.io/appveyor/ci/davidtheclark/cosmiconfig/master.svg?label=windows%20build)](https://ci.appveyor.com/project/davidtheclark/cosmiconfig/branch/master)

Find and load a configuration object from
- a `package.json` property (anywhere down the file tree)
- a JSON or YAML "rc file" (anywhere down the file tree)
- a `.config.js` CommonJS module (anywhere down the file tree)
- a CLI `--config` argument

For example, if your module's name is "soursocks," cosmiconfig will search out configuration in the following places:
- a `soursocks` property in `package.json` (anywhere down the file tree)
- a `.soursocksrc` file in JSON or YAML format (anywhere down the file tree)
- a `soursocks.config.js` file exporting a JS object (anywhere down the file tree)
- a CLI `--config` argument

cosmiconfig continues to search in these places all the way down the file tree until it finds acceptable configuration (or hits the home directory). And it does all this asynchronously, so it shouldn't get in your way.

Additionally, all of these search locations are configurable: you can customize filenames or turn off any location.

You can also look for rc files with extensions, e.g. `.soursocksrc.json` or `.soursocksrc.yaml`.
You may like extensions on your rc files because you'll get syntax highlighting and linting in text editors.

## Installation

```
npm install cosmiconfig
```

Tested in Node 0.10+.

## Usage

```js
var cosmiconfig = require('cosmiconfig');

cosmiconfig(yourModuleName[, options])
  .then(function(result) {
    // result.config is the parsed configuration object
    // result.filepath is the path to the config file that was found
  })
  .catch(function(parsingError) {
    // do something constructive
  });
```

The function `cosmiconfig()` searches for a configuration object and returns a Promise,
which resolves with an object containing the information you're looking for.

So let's say `var yourModuleName = 'goldengrahams'` — here's how cosmiconfig will work:

- Starting from `process.cwd()` (or some other directory defined by `options.cwd`), it looks for configuration objects in three places, in this order:
  1. A `goldengrahams` property in a `package.json` file (or some other property defined by `options.packageProp`);
  2. A `.goldengrahamsrc` file with JSON or YAML syntax (or some other filename defined by `options.rc`);
  3. A `goldengrahams.config.js` JS file exporting the object (or some other filename defined by `options.js`).
- If none of those searches reveal a configuration object, it moves down one directory and tries again. So the search continues in `./`, `../`, `../../`, `../../../`, etc., checking those three locations in each directory.
- It continues searching until it arrives at your home directory (or some other directory defined by `options.stopDir`).
- If at any point a parseable configuration is found, the `cosmiconfig()` Promise resolves with its result object.
- If no configuration object is found, the `cosmiconfig()` Promise resolves with `null`.
- If a configuration object is found *but is malformed* (causing a parsing error), the `cosmiconfig()` Promise rejects and shares that error (so you should `.catch()` it).

All this searching can be short-circuited by passing `options.configPath` or a `--config` CLI argument to specify a file.
cosmiconfig will read that file and try parsing it as JSON, YAML, or JS.

## API

### cosmiconfig(moduleName[, options])

Returns a promise that resolves with `null` (if no configuration was found) or an object with the following properties:

- **config**: The parsed configuration object that was found.
- **filepath**: The path to the file that housed that configuration object.

#### moduleName

Type: `string`

You module name. This is used to create the default filenames that cosmiconfig will look for.

#### Options

##### packageProp

Type: `string` or `false`
Default: `'[moduleName]'`

Name of the property in `package.json` to look for.

If `false`, cosmiconfig will not look in `package.json` files.

##### rc

Type: `string` or `false`
Default: `'.[moduleName]rc'`

Name of the "rc file" to look for, which can be formatted as JSON or YAML.

If `false`, cosmiconfig will not look for an rc file.

If `rcExtensions: true`, the rc file can also have extensions that specify the syntax, e.g. `.[moduleName]rc.json`.
You may like extensions on your rc files because you'll get syntax highlighting and linting in text editors.
Also, with `rcExtensions: true`, you can use JS modules as rc files, e.g. `.[moduleName]rc.js`.

##### js

Type: `string` or `false`
Default: `'[moduleName].config.js'`

Name of a JS file to look for, which must export the configuration object.

If `false`, cosmiconfig will not look for a JS file.

##### argv

Type: `string` or `false`
Default: `'config'`

Name of a `process.argv` argument to look for, whose value should be the path to a configuration file.
cosmiconfig will read the file and try to parse it as JSON, YAML, or JS.
By default, cosmiconfig looks for `--config`.

If `false`, cosmiconfig will not look for any `process.argv` arguments.

##### configPath

Type: `string`

Path to a configuration file. cosmiconfig will read it and try to parse it as JSON, YAML, or JS.

This option can be set via the command line with `--config`.

##### rcStrictJson

Type: `boolean`
Default: `false`

If `true`, cosmiconfig will expect rc files to be strict JSON. No YAML permitted, and no sloppy JSON.

By default, rc files are parsed with [js-yaml](https://github.com/nodeca/js-yaml), which is
more permissive with punctuation than standard strict JSON.

##### rcExtensions

Type: `boolean`
Default: `false`

If `true`, cosmiconfig will look for rc files with extensions, in addition to rc files without.

This adds a few steps to the search process.
Instead of *just* looking for `.goldengrahamsrc` (no extension), it will also look for the following, in this order:

- `.goldengrahamsrc.json`
- `.goldengrahamsrc.yaml`
- `.goldengrahamsrc.yml`
- `.goldengrahamsrc.js`

##### cwd

Type: `string`
Default: `process.cwd()`

Directory to start the search from.

##### stopDir

Type: `string`
Default: Absolute path to your home directory

Directory where the search will stop.

## Differences from [rc](https://github.com/dominictarr/rc)

[rc](https://github.com/dominictarr/rc) serves its focused purpose well. cosmiconfig differs in a few key ways — making it more useful for some projects, less useful for others:

- Looks for configuration in some different places: in a `package.json` property, an rc file, a `.config.js` file, and rc files with extensions.
- Built-in support for JSON, YAML, and CommonJS formats.
- Stops at the first configuration found, instead of finding all that can be found down the filetree and merging them automatically.
- Options.
- Asynchronicity.

## Contributing & Development

Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms.

And please do participate!
