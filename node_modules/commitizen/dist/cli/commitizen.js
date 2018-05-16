'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.bootstrap = undefined;

var _commitizen = require('../commitizen');

var _parsers = require('./parsers');

var _shelljs = require('shelljs');

var sh = _interopRequireWildcard(_shelljs);

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

var parse = _parsers.commitizen.parse;
exports.bootstrap = bootstrap;

/**
 * This is the main cli entry point.
 * environment may be used for debugging.
 */

function bootstrap() {
  var environment = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};


  // Get cli args
  var rawGitArgs = process.argv.slice(2, process.argv.length);

  // Parse the args
  var parsedArgs = parse(rawGitArgs);
  var command = parsedArgs._[0];

  // Do actions based on commands
  if (command === "init") {
    var adapterNpmName = parsedArgs._[1];
    if (adapterNpmName) {
      console.log('Attempting to initialize using the npm package ' + adapterNpmName);
      try {
        (0, _commitizen.init)(sh, process.cwd(), adapterNpmName, parsedArgs);
      } catch (e) {
        console.error('Error: ' + e);
      }
    } else {
      console.error('Error: You must provide an adapter name as the second argument.');
    }
  } else {
    console.log('\n    \n    Commitizen has two command line tools:\n    \n      1) commitizen -- used for installing adapters into your project\n      2) git-cz     -- used for making commits according to convention\n                       note: you can run \'git cz\' if installed with -g\n    \n    Generally if you\'re using someone else\'s repo and they\'ve already set up an\n    adapter, you\'re going to just be running:\n    \n         git-cz\n    \n    However, if you create a new repo and you want to make it easier for future \n    contributors to follow your commit message conventions using commitizen then\n    you\'ll need to run a command like this one to add this adapter to your config:\n        \n         commitizen init cz-conventional-changelog --save\n        \n    You should swap out cz-conventional-changelog for the NPM package name of the\n    adapter you wish you install in your project\'s package.json.\n    \n    Detailed usage:\n      \n      1) commitizen <sub-command>\n    \n         init <adapter-npm-name> [args]\n        \n           description: Install a commitizen adapter from npm and adds it to your\n                        config.commitizen in your package.json file.\n        \n           args:\n             --save         Install the adapter to package.json dependencies \n             --save-dev     Install the adapter to devDependencies\n             --save-exact   Install an exact version instead of a range\n             --force        Force install the adapter, even if a previous one exists.\n             \n      2) git-cz <any regular git commit arguments>\n      \n          description: Runs the commitizen prompter, asking you questions so that you\n                       follow the commit conventions of the repository of the current \n                       directory.\n                       \n                       note: git-cz may even be run as \'git cz\' if installed with -g.\n    \n    ');
  }
}