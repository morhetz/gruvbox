var fs = require('graceful-fs')
var path = require('path')

var walkSync = function (dir, filelist) {
  var files = fs.readdirSync(dir)
  filelist = filelist || []
  files.forEach(function (file) {
    var nestedPath = path.join(dir, file)
    if (fs.lstatSync(nestedPath).isDirectory()) {
      filelist = walkSync(nestedPath, filelist)
    } else {
      filelist.push(nestedPath)
    }
  })
  return filelist
}

module.exports = {
  walkSync: walkSync
}
