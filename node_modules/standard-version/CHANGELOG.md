# Change Log

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

<a name="4.3.0"></a>
# [4.3.0](https://github.com/conventional-changelog/standard-version/compare/v4.2.0...v4.3.0) (2018-01-03)


### Bug Fixes

* recommend `--tag` prerelease for npm publish of prereleases ([#196](https://github.com/conventional-changelog/standard-version/issues/196)) ([709dae1](https://github.com/conventional-changelog/standard-version/commit/709dae1)), closes [#183](https://github.com/conventional-changelog/standard-version/issues/183)
* use the `skip` default value for skip cli arg ([#211](https://github.com/conventional-changelog/standard-version/issues/211)) ([3fdd7fa](https://github.com/conventional-changelog/standard-version/commit/3fdd7fa))


### Features

* **format-commit-message:** support multiple %s in the message ([45fcad5](https://github.com/conventional-changelog/standard-version/commit/45fcad5))
* do not update/commit files in .gitignore ([#230](https://github.com/conventional-changelog/standard-version/issues/230)) ([4fd3bc2](https://github.com/conventional-changelog/standard-version/commit/4fd3bc2))
* publish only if commit+push succeed ([#229](https://github.com/conventional-changelog/standard-version/issues/229)) ([c5e1ee2](https://github.com/conventional-changelog/standard-version/commit/c5e1ee2))



<a name="4.2.0"></a>
# [4.2.0](https://github.com/conventional-changelog/standard-version/compare/v4.1.0...v4.2.0) (2017-06-12)


### Features

* add support for `package-lock.json` ([#190](https://github.com/conventional-changelog/standard-version/issues/190)) ([bc0fc53](https://github.com/conventional-changelog/standard-version/commit/bc0fc53))



<a name="4.1.0"></a>
# [4.1.0](https://github.com/conventional-changelog/standard-version/compare/v4.0.0...v4.1.0) (2017-06-06)


### Features

* **cli:** print error and don't run with node <4, closes [#124](https://github.com/conventional-changelog/standard-version/issues/124) ([d0d71a5](https://github.com/conventional-changelog/standard-version/commit/d0d71a5))
* add dry-run mode ([#187](https://github.com/conventional-changelog/standard-version/issues/187)) ([d073353](https://github.com/conventional-changelog/standard-version/commit/d073353))
* add prebump, postbump, precommit, lifecycle scripts ([#186](https://github.com/conventional-changelog/standard-version/issues/186)) ([dfd1d12](https://github.com/conventional-changelog/standard-version/commit/dfd1d12))
* add support for `npm-shrinkwrap.json` ([#185](https://github.com/conventional-changelog/standard-version/issues/185)) ([86af7fc](https://github.com/conventional-changelog/standard-version/commit/86af7fc))
* add support for skipping lifecycle steps, polish lifecycle work ([#188](https://github.com/conventional-changelog/standard-version/issues/188)) ([d31dcdb](https://github.com/conventional-changelog/standard-version/commit/d31dcdb))
* allow a version # to be provided for release-as, rather than just major, minor, patch. ([13eb9cd](https://github.com/conventional-changelog/standard-version/commit/13eb9cd))



<a name="4.0.0"></a>
# [4.0.0](https://github.com/conventional-changelog/standard-version/compare/v4.0.0-1...v4.0.0) (2016-12-02)


### Bug Fixes

* include merge commits in the changelog ([#139](https://github.com/conventional-changelog/standard-version/issues/139)) ([b6e1562](https://github.com/conventional-changelog/standard-version/commit/b6e1562))
* should print message before we bump version ([2894bbc](https://github.com/conventional-changelog/standard-version/commit/2894bbc))
* support a wording change made to git status in git v2.9.1 ([#140](https://github.com/conventional-changelog/standard-version/issues/140)) ([80004ec](https://github.com/conventional-changelog/standard-version/commit/80004ec))


### Features

* add support for bumping version # in bower.json ([#148](https://github.com/conventional-changelog/standard-version/issues/148)) ([b788c5f](https://github.com/conventional-changelog/standard-version/commit/b788c5f))
* make tag prefix configurable ([#143](https://github.com/conventional-changelog/standard-version/issues/143)) ([70b20c8](https://github.com/conventional-changelog/standard-version/commit/70b20c8))
* support releasing a custom version, including pre-releases ([#129](https://github.com/conventional-changelog/standard-version/issues/129)) ([068008d](https://github.com/conventional-changelog/standard-version/commit/068008d))


### BREAKING CHANGES

* merge commits are now included in the CHANGELOG.


<a name="3.0.0"></a>
# [3.0.0](https://github.com/conventional-changelog/standard-version/compare/v2.3.0...v3.0.0) (2016-10-06)


### Bug Fixes

* check the private field in package.json([#102](https://github.com/conventional-changelog/standard-version/issues/102)) ([#103](https://github.com/conventional-changelog/standard-version/issues/103)) ([2ce4160](https://github.com/conventional-changelog/standard-version/commit/2ce4160))
* **err:** don't fail on stderr output, but print the output to stderr ([#110](https://github.com/conventional-changelog/standard-version/issues/110)) ([f7a4915](https://github.com/conventional-changelog/standard-version/commit/f7a4915)), closes [#91](https://github.com/conventional-changelog/standard-version/issues/91)


### Chores

* package.json engines field >=4.0, drop Node 0.10 and 0.12 ([28ff65a](https://github.com/conventional-changelog/standard-version/commit/28ff65a))


### Features

* **options:** add --silent flag and option for squelching output ([2a3fa61](https://github.com/conventional-changelog/standard-version/commit/2a3fa61))
* added support for commitAll option in CLI ([#121](https://github.com/conventional-changelog/standard-version/issues/121)) ([a903f4d](https://github.com/conventional-changelog/standard-version/commit/a903f4d))
* separate cli and defaults from base functionality ([34a6a4e](https://github.com/conventional-changelog/standard-version/commit/34a6a4e))


### BREAKING CHANGES

* drop support for Node < 4.0 to enable usage of
new tools and packages.



<a name="2.4.0"></a>
# [2.4.0](https://github.com/conventional-changelog/standard-version/compare/v2.3.1...v2.4.0) (2016-07-13)


### Bug Fixes

* **index.js:** use blue figures.info for last checkpoint ([#64](https://github.com/conventional-changelog/standard-version/issues/64)) ([e600b42](https://github.com/conventional-changelog/standard-version/commit/e600b42))


### Features

* **changelogStream:** use more default opts ([#67](https://github.com/conventional-changelog/standard-version/issues/67)) ([3e0aa84](https://github.com/conventional-changelog/standard-version/commit/3e0aa84))



<a name="2.3.1"></a>
## [2.3.1](https://github.com/conventional-changelog/standard-version/compare/v2.3.0...v2.3.1) (2016-06-15)


### Bug Fixes

* **commit:** fix windows by separating add and commit exec ([#55](https://github.com/conventional-changelog/standard-version/issues/55)) ([f361c46](https://github.com/conventional-changelog/standard-version/commit/f361c46)), closes [#55](https://github.com/conventional-changelog/standard-version/issues/55) [#49](https://github.com/conventional-changelog/standard-version/issues/49)



<a name="2.3.0"></a>
# [2.3.0](https://github.com/conventional-changelog/standard-version/compare/v2.2.1...v2.3.0) (2016-06-02)


### Bug Fixes

* append line feed to end of package.json ([#42](https://github.com/conventional-changelog/standard-version/issues/42))([178e001](https://github.com/conventional-changelog/standard-version/commit/178e001))


### Features

* **index.js:** add checkpoint for publish script after tag successfully ([#47](https://github.com/conventional-changelog/standard-version/issues/47))([e414ed7](https://github.com/conventional-changelog/standard-version/commit/e414ed7))
* add a --no-verify option to prevent git hooks from being verified ([#44](https://github.com/conventional-changelog/standard-version/issues/44))([026d844](https://github.com/conventional-changelog/standard-version/commit/026d844))



<a name="2.2.1"></a>
## [2.2.1](https://github.com/conventional-changelog/standard-version/compare/v2.2.0...v2.2.1) (2016-05-02)


### Bug Fixes

* upgrade to version of nyc that works with new shelljs([c7ac6e2](https://github.com/conventional-changelog/standard-version/commit/c7ac6e2))



<a name="2.2.0"></a>
# [2.2.0](https://github.com/conventional-changelog/standard-version/compare/v2.1.2...v2.2.0) (2016-05-01)


### Bug Fixes

* format the annotated tag message ([#28](https://github.com/conventional-changelog/standard-version/issues/28))([8f02736](https://github.com/conventional-changelog/standard-version/commit/8f02736))
* upgraded dependencies, switched back to angular format (fixes [#27](https://github.com/conventional-changelog/standard-version/issues/27)), pinned shelljs to version that works with nyc ([#30](https://github.com/conventional-changelog/standard-version/issues/30))([3f51e94](https://github.com/conventional-changelog/standard-version/commit/3f51e94))


### Features

* add --sign flag to sign git commit and tag ([#29](https://github.com/conventional-changelog/standard-version/issues/29))([de758bc](https://github.com/conventional-changelog/standard-version/commit/de758bc))



<a name="2.1.2"></a>
## [2.1.2](https://github.com/conventional-changelog/standard-version/compare/v2.1.1...v2.1.2) (2016-04-11)


### Bug Fixes

* we had too many \n characters ([#17](https://github.com/conventional-changelog/standard-version/issues/17)) ([67a01cd](https://github.com/conventional-changelog/standard-version/commit/67a01cd))



<a name="2.1.1"></a>
## [2.1.1](https://github.com/conventional-changelog/standard-version/compare/v2.1.0...v2.1.1) (2016-04-10)


### Bug Fixes

* **docs:** had a bad URL in package.json, which was breaking all of our links ([caa6359](https://github.com/conventional-changelog/standard-version/commit/caa6359))



<a name="2.1.0"></a>
# [2.1.0](https://github.com/conventional-changelog/standard-version/compare/v2.0.0...v2.1.0) (2016-04-10)


### Features

* adds support for GitHub links (see [#13](https://github.com/conventional-changelog/standard-version/issues/13)), great idea [@bcoe](https://github.com/bcoe)! ([7bf6597](https://github.com/conventional-changelog/standard-version/commit/7bf6597))



<a name="2.0.0"></a>
# [2.0.0](https://github.com/conventional-changelog/standard-version/compare/v1.1.0...v2.0.0) (2016-04-09)


* feat(conventional-changelog-standard): Move to conventional-changelog-standard style. This style lifts the character limit on commit messages, and puts us in a position to make more opinionated decisions in the future. ([c7ccadb](https://github.com/conventional-changelog/standard-version/commit/c7ccadb))


### BREAKING CHANGES

* we no longer accept the preset configuration option.


<a name="1.1.0"></a>
# [1.1.0](https://github.com/conventional-changelog/standard-version/compare/v1.0.0...v1.1.0) (2016-04-08)


### Features

* **cli:** use conventional default commit message with version ([9fadc5f](https://github.com/conventional-changelog/standard-version/commit/9fadc5f))
* **rebrand:** rebrand recommended-workflow to standard-version (#9) ([1f673c0](https://github.com/conventional-changelog/standard-version/commit/1f673c0))
* **tests:** adds test suite, fixed several Node 0.10 issues along the way ([03bd86c](https://github.com/conventional-changelog/standard-version/commit/03bd86c))



<a name="1.0.0"></a>
# 1.0.0 (2016-04-04)


### Features

* **initial-release:** adds flag for generating CHANGELOG.md on the first release. ([b812b44](https://github.com/bcoe/conventional-recommended-workflow/commit/b812b44))
