'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.bootstrap = undefined;

var _commitizen = require('../commitizen');

var _strategies = require('./strategies');

exports.bootstrap = bootstrap;

/**
 * This is the main cli entry point.
 * environment may be used for debugging.
 */

function bootstrap() {
  var environment = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};


  // Get cli args
  var rawGitArgs = process.argv.slice(2, process.argv.length);

  var adapterConfig = environment.config || _commitizen.configLoader.load();

  // Choose a strategy based on the existance the adapter config
  if (typeof adapterConfig !== 'undefined') {
    // This tells commitizen we're in business
    (0, _strategies.gitCz)(rawGitArgs, environment, adapterConfig);
  } else {
    // This tells commitizen that it is not needed, just use git
    (0, _strategies.git)(rawGitArgs, environment);
  }
}