# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

<a name="2.0.11"></a>
## [2.0.11](https://github.com/conventional-changelog/conventional-changelog/compare/conventional-changelog-core@2.0.10...conventional-changelog-core@2.0.11) (2018-04-16)


### Bug Fixes

* `tagPrefix` was not passed properly in conventional-changelog-core ([#300](https://github.com/conventional-changelog/conventional-changelog/issues/300)) ([be48f70](https://github.com/conventional-changelog/conventional-changelog/commit/be48f70))




<a name="2.0.10"></a>
## [2.0.10](https://github.com/conventional-changelog/conventional-changelog/compare/conventional-changelog-core@2.0.9...conventional-changelog-core@2.0.10) (2018-03-28)




**Note:** Version bump only for package conventional-changelog-core

<a name="2.0.9"></a>
## [2.0.9](https://github.com/conventional-changelog/conventional-changelog/compare/conventional-changelog-core@2.0.8...conventional-changelog-core@2.0.9) (2018-03-27)




**Note:** Version bump only for package conventional-changelog-core

<a name="2.0.8"></a>
## [2.0.8](https://github.com/conventional-changelog/conventional-changelog/compare/conventional-changelog-core@2.0.7...conventional-changelog-core@2.0.8) (2018-03-27)




**Note:** Version bump only for package conventional-changelog-core

<a name="2.0.7"></a>
## [2.0.7](https://github.com/conventional-changelog/conventional-changelog/compare/conventional-changelog-core@2.0.6...conventional-changelog-core@2.0.7) (2018-03-27)




**Note:** Version bump only for package conventional-changelog-core

<a name="2.0.6"></a>
## [2.0.6](https://github.com/conventional-changelog/conventional-changelog/compare/conventional-changelog-core@2.0.5...conventional-changelog-core@2.0.6) (2018-03-22)




**Note:** Version bump only for package conventional-changelog-core

<a name="2.0.5"></a>
## [2.0.5](https://github.com/conventional-changelog/conventional-changelog/compare/conventional-changelog-core@2.0.4...conventional-changelog-core@2.0.5) (2018-02-24)




**Note:** Version bump only for package conventional-changelog-core

<a name="2.0.4"></a>
## [2.0.4](https://github.com/conventional-changelog/conventional-changelog/compare/conventional-changelog-core@2.0.3...conventional-changelog-core@2.0.4) (2018-02-20)




**Note:** Version bump only for package conventional-changelog-core

<a name="2.0.3"></a>
## [2.0.3](https://github.com/conventional-changelog/conventional-changelog-core/compare/conventional-changelog-core@2.0.2...conventional-changelog-core@2.0.3) (2018-02-13)




**Note:** Version bump only for package conventional-changelog-core

<a name="2.0.2"></a>
## [2.0.2](https://github.com/conventional-changelog/conventional-changelog-core/compare/conventional-changelog-core@2.0.1...conventional-changelog-core@2.0.2) (2018-02-13)




**Note:** Version bump only for package conventional-changelog-core

<a name="2.0.1"></a>
## [2.0.1](https://github.com/conventional-changelog/conventional-changelog-core/compare/conventional-changelog-core@2.0.0...conventional-changelog-core@2.0.1) (2018-02-05)




**Note:** Version bump only for package conventional-changelog-core

<a name="2.0.0"></a>
# [2.0.0](https://github.com/conventional-changelog/conventional-changelog-core/compare/conventional-changelog-core@1.9.5...conventional-changelog-core@2.0.0) (2018-01-29)


### Bug Fixes

* **writer:** normalize release headings ([#237](https://github.com/conventional-changelog/conventional-changelog-core/issues/237)) ([9e87dc3](https://github.com/conventional-changelog/conventional-changelog-core/commit/9e87dc3)), closes [/github.com/conventional-changelog/conventional-changelog/issues/214#issuecomment-326681934](https://github.com//github.com/conventional-changelog/conventional-changelog/issues/214/issues/issuecomment-326681934)


### BREAKING CHANGES

* **writer:** Logic for generating release headings has been changed to make all
heading levels the same (`##`/`h2`) for better compatibility with
screen readers and parsers, and to conform to HTML semantics. Patch
release titles are now wrapped in a `<small>` tag to maintain the
visual hierarchy of the previous style.

Fixes https://github.com/conventional-changelog/conventional-changelog/issues/214




<a name="1.9.5"></a>
## [1.9.5](https://github.com/conventional-changelog/conventional-changelog-core/compare/conventional-changelog-core@1.9.4...conventional-changelog-core@1.9.5) (2017-12-18)




**Note:** Version bump only for package conventional-changelog-core

<a name="1.9.4"></a>
## [1.9.4](https://github.com/conventional-changelog/conventional-changelog-core/compare/conventional-changelog-core@1.9.3...conventional-changelog-core@1.9.4) (2017-12-08)




**Note:** Version bump only for package conventional-changelog-core

<a name="1.9.3"></a>
## [1.9.3](https://github.com/conventional-changelog/conventional-changelog-core/compare/conventional-changelog-core@1.9.2...conventional-changelog-core@1.9.3) (2017-11-13)




**Note:** Version bump only for package conventional-changelog-core

<a name="1.9.2"></a>
## [1.9.2](https://github.com/conventional-changelog/conventional-changelog-core/compare/conventional-changelog-core@1.9.1...conventional-changelog-core@1.9.2) (2017-10-01)

<a name="1.9.1"></a>
## [1.9.1](https://github.com/conventional-changelog/conventional-changelog-core/compare/conventional-changelog-core@1.9.0...conventional-changelog-core@1.9.1) (2017-09-01)

<a name="1.9.0"></a>
# [1.9.0](https://github.com/conventional-changelog/conventional-changelog-core/compare/conventional-changelog-core@1.8.0...conventional-changelog-core@1.9.0) (2017-07-17)


### Features

* **context:** default currentTag may not prefix with v ([#179](https://github.com/conventional-changelog/conventional-changelog/issues/179)) ([431598a](https://github.com/conventional-changelog/conventional-changelog-core/commit/431598a))

<a name="1.8.0"></a>
# [1.8.0](https://github.com/conventional-changelog/conventional-changelog-core/compare/conventional-changelog-core@1.7.0...conventional-changelog-core@1.8.0) (2017-03-11)


### Features

* context.currentTag should take into account lerna tag format ([#178](https://github.com/conventional-changelog/conventional-changelog/issues/178)) ([f0e5875](https://github.com/conventional-changelog/conventional-changelog-core/commit/f0e5875))

<a name="1.5.0"></a>
# [1.5.0](https://github.com/conventional-changelog/conventional-changelog-core/compare/v1.4.0...v1.5.0) (2016-05-10)


### Features

* **context:** fallback to repoUrl([da0b096](https://github.com/conventional-changelog/conventional-changelog-core/commit/da0b096)), closes [#7](https://github.com/conventional-changelog/conventional-changelog-core/issues/7)



<a name="1.4.0"></a>
# [1.4.0](https://github.com/conventional-changelog/conventional-changelog-core/compare/v1.3.4...v1.4.0) (2016-05-08)


### Features

* **debug:** make options.debug as default writeOpts.debug([eeb7e8f](https://github.com/conventional-changelog/conventional-changelog-core/commit/eeb7e8f))



<a name="1.3.4"></a>
## [1.3.4](https://github.com/conventional-changelog/conventional-changelog-core/compare/v1.3.3...v1.3.4) (2016-05-07)


### Bug Fixes

* **mergeConfig:** respect issuePrefixes option ([4be052b](https://github.com/conventional-changelog/conventional-changelog-core/commit/4be052b)), closes [#6](https://github.com/conventional-changelog/conventional-changelog-core/issues/6) [#8](https://github.com/conventional-changelog/conventional-changelog-core/issues/8)



<a name="1.3.3"></a>
## [1.3.3](https://github.com/conventional-changelog/conventional-changelog-core/compare/v1.3.2...v1.3.3) (2016-04-19)


### Bug Fixes

* **unknownHost:** default context.repository ([eaa3b6f](https://github.com/conventional-changelog/conventional-changelog-core/commit/eaa3b6f))



<a name="1.3.2"></a>
## [1.3.2](https://github.com/conventional-changelog/conventional-changelog-core/compare/v1.3.1...v1.3.2) (2016-04-17)




<a name="1.3.1"></a>
## [1.3.1](https://github.com/conventional-changelog/conventional-changelog-core/compare/v1.3.0...v1.3.1) (2016-04-09)


### Bug Fixes

* **defaults:** context tags ([2571038](https://github.com/conventional-changelog/conventional-changelog-core/commit/2571038))



<a name="1.3.0"></a>
# [1.3.0](https://github.com/stevemao/conventional-changelog-core/compare/v1.2.0...v1.3.0) (2016-02-13)


### Features

* **debug:** add options.debug function ([aa56ae6](https://github.com/stevemao/conventional-changelog-core/commit/aa56ae6))



<a name="1.2.0"></a>
# [1.2.0](https://github.com/stevemao/conventional-changelog-core/compare/v1.1.0...v1.2.0) (2016-02-11)


### Features

* **merge:** ignore merge commits ([8f788dc](https://github.com/stevemao/conventional-changelog-core/commit/8f788dc))



<a name="1.1.0"></a>
# [1.1.0](https://github.com/stevemao/conventional-changelog-core/compare/v1.0.2...v1.1.0) (2016-02-08)


### Bug Fixes

* **default:** firstCommit and lastCommit should based on original unfiltered commits ([7fc49c9](https://github.com/stevemao/conventional-changelog-core/commit/7fc49c9)), closes [#2](https://github.com/stevemao/conventional-changelog-core/issues/2)



<a name="1.0.2"></a>
## [1.0.2](https://github.com/stevemao/conventional-changelog-core/compare/v1.0.1...v1.0.2) (2016-02-06)


### Bug Fixes

* **currentTag:** if unreleased, currentTag should be last commit hash ([e3d25ae](https://github.com/stevemao/conventional-changelog-core/commit/e3d25ae))



<a name="1.0.1"></a>
## [1.0.1](https://github.com/stevemao/conventional-changelog-core/compare/v1.0.0...v1.0.1) (2016-02-06)


### Bug Fixes

* **unreleased:** now it can output unreleased commits ([87b7340](https://github.com/stevemao/conventional-changelog-core/commit/87b7340))



<a name="1.0.0"></a>
# [1.0.0](https://github.com/stevemao/conventional-changelog-core/compare/v0.0.2...v1.0.0) (2016-02-05)


### Bug Fixes

* **oldNode:** git remote origin url feature is only available under node>=4 ([c69db53](https://github.com/stevemao/conventional-changelog-core/commit/c69db53))

### Features

* **pkg:** fallback to git remote origin url ([5b56952](https://github.com/stevemao/conventional-changelog-core/commit/5b56952))
* **unreleased:** option to output or not unreleased changelog ([9dfe8d8](https://github.com/stevemao/conventional-changelog-core/commit/9dfe8d8)), closes [ajoslin/conventional-changelog#120](https://github.com/ajoslin/conventional-changelog/issues/120)


### BREAKING CHANGES

* unreleased: If `context.version` is the same as the version of the last release, by default the unreleased chagnelog will not output.



<a name="0.0.2"></a>
## [0.0.2](https://github.com/stevemao/conventional-changelog-core/compare/v0.0.1...v0.0.2) (2016-01-30)


### Bug Fixes

* **error:** better error handling ([614ce1a](https://github.com/stevemao/conventional-changelog-core/commit/614ce1a)), closes [ajoslin/conventional-changelog#130](https://github.com/ajoslin/conventional-changelog/issues/130)



<a name="0.0.1"></a>
## 0.0.1 (2015-12-26)


### Features

* **config:** change preset to config ([85fd9d9](https://github.com/stevemao/conventional-changelog-core/commit/85fd9d9))
* **init:** extract core from conventional-changelog ([4a4bca3](https://github.com/stevemao/conventional-changelog-core/commit/4a4bca3))


### BREAKING CHANGES

* config: `options.preset` is removed in favour of `options.config`
