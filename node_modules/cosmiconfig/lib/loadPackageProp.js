'use strict';

var path = require('path');
var fs = require('graceful-fs');
var Promise = require('pinkie-promise');
var parseJson = require('parse-json');

module.exports = function(packageDir, packageProp) {
  var packagePath = path.join(packageDir, 'package.json');
  return new Promise(function(resolve, reject) {
    fs.readFile(packagePath, 'utf8', function(fileError, content) {
      if (fileError) {
        if (fileError.code === 'ENOENT') return resolve(null);
        return reject(fileError);
      }
      resolve(content);
    });
  }).then(function(content) {
    if (!content) return null;
    var parsedContent = parseJson(content, packagePath);
    var packagePropValue = parsedContent[packageProp];
    if (!packagePropValue) return null;

    return {
      config: packagePropValue,
      filepath: packagePath,
    };
  });
};
