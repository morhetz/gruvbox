const util = require('util')

module.exports = function (rawMsg, newVersion) {
  const message = String(rawMsg)
  const matchCount = (message.match(/%s/g) || []).length
  const args = Array(1 + matchCount)
  args[0] = message
  args.fill(newVersion, 1, args.length)
  return util.format.apply(util, args)
}
