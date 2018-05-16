'use strict';

exports.isListr = obj => Boolean(obj && obj.setRenderer && obj.add && obj.run);
// https://github.com/sindresorhus/is-observable/issues/1
exports.isObservable = obj => Boolean(obj && typeof obj.subscribe === 'function' && obj.constructor.name === 'Observable');
