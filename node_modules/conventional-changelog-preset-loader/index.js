'use strict'
module.exports = presetLoader(require)
module.exports.presetLoader = presetLoader

function presetLoader (requireMethod) {
  return path => {
    let scope = ``
    let name = path.toLowerCase()

    if (name[0] === `@`) {
      const parts = name.split(`/`)
      scope = parts.shift() + `/`
      name = parts.join(`/`)
    }

    return requireMethod(`${scope}conventional-changelog-${name}`)
  }
}
