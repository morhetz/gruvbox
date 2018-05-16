# Standard Version

[![Build Status](https://travis-ci.org/conventional-changelog/standard-version.svg?branch=master)](https://travis-ci.org/conventional-changelog/standard-version)
[![NPM version](https://img.shields.io/npm/v/standard-version.svg)](https://www.npmjs.com/package/standard-version)
[![Coverage Status](https://coveralls.io/repos/conventional-changelog/standard-version/badge.svg?branch=)](https://coveralls.io/r/conventional-changelog/standard-version?branch=master)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![community slack](http://devtoolscommunity.herokuapp.com/badge.svg)](http://devtoolscommunity.herokuapp.com)

_Having problems? want to contribute? join our [community slack](http://devtoolscommunity.herokuapp.com)_.

> stop using `npm version`, use `standard-version` it rocks!

Automatic versioning and CHANGELOG generation, using GitHub's squash button and
[conventional commit messages](https://conventionalcommits.org).

_how it works:_

1. when you land commits on your `master` branch, select the _Squash and Merge_ option.
2. add a title and body that follows the [Conventional Commits Specification](https://conventionalcommits.org).
3. when you're ready to release to npm:
  1. `git checkout master; git pull origin master`
  2. run `standard-version`
  3. `git push --follow-tags origin master && npm publish`

`standard-version` does the following:

1. bumps the version in _package.json/bower.json_ (based on your commit history)
2. uses [conventional-changelog](https://github.com/conventional-changelog/conventional-changelog) to update _CHANGELOG.md_
3. commits _package.json (et al.)_ and _CHANGELOG.md_
4. tags a new release

## Installation

### As `npm run` script

Install and add to `devDependencies`:

```
npm i --save-dev standard-version
```

Add an [`npm run` script](https://docs.npmjs.com/cli/run-script) to your _package.json_:

```json
{
  "scripts": {
    "release": "standard-version"
  }
}
```

Now you can use `npm run release` in place of `npm version`.

This has the benefit of making your repo/package more portable, so that other developers can cut releases without having to globally install `standard-version` on their machine.

### As global bin

Install globally (add to your `PATH`):

```
npm i -g standard-version
```

Now you can use `standard-version` in place of `npm version`.

This has the benefit of allowing you to use `standard-version` on any repo/package without adding a dev dependency to each one.

## CLI Usage

### First Release

To generate your changelog for your first release, simply do:

```sh
# npm run script
npm run release -- --first-release
# or global bin
standard-version --first-release
```

This will tag a release **without bumping the version in package.json (_et al._)**.

When ready, push the git tag and `npm publish` your first release. \o/

### Cut a Release

If you typically use `npm version` to cut a new release, do this instead:

```sh
# npm run script
npm run release
# or global bin
standard-version
```

As long as your git commit messages are conventional and accurate, you no longer need to specify the semver type - and you get CHANGELOG generation for free! \o/

After you cut a release, you can push the new git tag and `npm publish` (or `npm publish --tag next`) when you're ready.

### Release as a pre-release

Use the flag `--prerelease` to generate pre-releases:

Suppose the last version of your code is `1.0.0`, and your code to be committed has patched changes. Run:

```bash
# npm run script
npm run release -- --prerelease
```
you will get version `1.0.1-0`.

If you want to name the pre-release, you specify the name via `--prerelease <name>`.

For example, suppose your pre-release should contain the `alpha` prefix:

```bash
# npm run script
npm run release -- --prerelease alpha
```

this will tag the version `1.0.1-alpha.0`

### Release as a target type imperatively like `npm version`

To forgo the automated version bump use `--release-as` with the argument `major`, `minor` or `patch`:

Suppose the last version of your code is `1.0.0`, you've only landed `fix:` commits, but
you would like your next release to be a `minor`. Simply do:

```bash
# npm run script
npm run release -- --release-as minor
# Or
npm run release -- --release-as 1.1.0
```

you will get version `1.1.0` rather than the auto generated version `1.0.1`.

> **NOTE:** you can combine `--release-as` and `--prerelease` to generate a release. This is useful when publishing experimental feature(s).

### Prevent Git Hooks

If you use git hooks, like pre-commit, to test your code before committing, you can prevent hooks from being verified during the commit step by passing the `--no-verify` option:

```sh
# npm run script
npm run release -- --no-verify
# or global bin
standard-version --no-verify
```

### Signing commits and tags

If you have your GPG key set up, add the `--sign` or `-s` flag to your `standard-version` command.

### Lifecycle scripts

`standard-version` supports lifecycle scripts. These allow you to execute your
own supplementary commands during the release. The following
hooks are available and execute in the order documented:

* `prebump`/`postbump`: executed before and after the version is bumped. If the `prebump`
  script returns a version #, it will be used rather than
  the version calculated by `standard-version`.
* `prechangelog`/`postchangelog`: executes before and after the CHANGELOG is generated.
* `precommit`/`postcommit`: called before and after the commit step.
* `pretag`/`posttag`: called before and after the tagging step.

Simply add the following to your package.json to configure lifecycle scripts:

```json
{
  "standard-version": {
    "scripts": {
      "prebump": "echo 9.9.9"
    }
  }
}
```

### Skipping lifecycle steps

You can skip any of the lifecycle steps (`bump`, `changelog`, `commit`, `tag`),
by adding the following to your package.json:

```json
{
  "standard-version": {
    "skip": {
      "changelog": true
    }
  }
}
```

### Committing generated artifacts in the release commit

If you want to commit generated artifacts in the release commit (e.g. [#96](https://github.com/conventional-changelog/standard-version/issues/96)), you can use the `--commit-all` or `-a` flag. You will need to stage the artifacts you want to commit, so your `release` command could look like this:

```json
"prerelease": "webpack -p --bail",
"release": "git add <file(s) to commit> && standard-version -a"
```

### Dry run mode

running `standard-version` with the flag `--dry-run` allows you to see what
commands would be run, without committing to git or updating files.

```sh
# npm run script
npm run release -- --dry-run
# or global bin
standard-version --dry-run
```

### CLI Help

```sh
# npm run script
npm run release -- --help
# or global bin
standard-version --help
```

## Code usage

Use the `silent` option to stop `standard-version` from printing anything
to the console.

```js
var standardVersion = require('standard-version')

// Options are the same as command line, except camelCase
standardVersion({
  noVerify: true,
  infile: 'docs/CHANGELOG.md',
  silent: true
}, function (err) {
  if (err) {
    console.error(`standard-version failed with message: ${err.message}`)
  }
  // standard-version is done
})
```

## Commit Message Convention, at a Glance

_patches:_

```sh
git commit -a -m "fix(parsing): fixed a bug in our parser"
```

_features:_

```sh
git commit -a -m "feat(parser): we now have a parser \o/"
```

_breaking changes:_

```sh
git commit -a -m "feat(new-parser): introduces a new parsing library
BREAKING CHANGE: new library does not support foo-construct"
```

_other changes:_

You decide, e.g., docs, chore, etc.

```sh
git commit -a -m "docs: fixed up the docs a bit"
```

_but wait, there's more!_

Github usernames (`@bcoe`) and issue references (#133) will be swapped out for the
appropriate URLs in your CHANGELOG.

## Badges!

Tell your users that you adhere to the Conventional Commits specification:

```markdown
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
```

## FAQ

### How is `standard-version` different from `semantic-release`?

[`semantic-release`](https://github.com/semantic-release/semantic-release) is a fully automated library/system for versioning, changelog generation, git tagging, and publishing to the npm registry.

`standard-version` is different because it handles the versioning, changelog generation, and git tagging for you **without** automatic pushing (to GitHub) or publishing (to an npm registry). Use of `standard-version` only affects your local git repo - it doesn't affect remote resources at all. After you run `standard-version`, you still have to ability to review things and correct mistakes if you want to.

They are both based on the same foundation of structured commit messages (using [Angular format](https://github.com/bcoe/conventional-changelog-standard/blob/master/convention.md)), but `standard-version` is a good choice for folks who are not yet comfortable letting publishes go out automatically. In this way, you can view `standard-version` as an incremental step to adopting `semantic-release`.

We think they are both fantastic tools, and we encourage folks to use `semantic-release` instead of `standard-version` if it makes sense for them.

### Should I always squash commits when merging PRs?

The instructions to squash commits when merging pull requests assumes that **one PR equals, at most, one feature or fix**.

If you have multiple features or fixes landing in a single PR and each commit uses a structured message, then you can do a standard merge when accepting the PR. This will preserve the commit history from your branch after the merge.

Although this will allow each commit to be included as separate entries in your CHANGELOG, the entries will **not** be able to reference the PR that pulled the changes in because the preserved commit messages do not include the PR number.

For this reason, we recommend keeping the scope of each PR to one general feature or fix. In practice, this allows you to use unstructured commit messages when committing each little change and then squash them into a single commit with a structured message (referencing the PR number) once they have been reviewed and accepted.

## License

ISC
