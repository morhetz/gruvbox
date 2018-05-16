'use strict';
const state = require('./state');

class TaskWrapper {

	constructor(task) {
		this._task = task;
	}

	set title(title) {
		this._task.title = title;

		this._task.next({
			type: 'TITLE',
			data: title
		});
	}

	get title() {
		return this._task.title;
	}

	skip(message) {
		if (message && typeof message !== 'string') {
			throw new TypeError(`Expected \`message\` to be of type \`string\`, got \`${typeof message}\``);
		}

		if (message) {
			this._task._output = message;
		}

		this._task.state = state.SKIPPED;
	}

	run(ctx) {
		return this._task.run(ctx, this);
	}
}

module.exports = TaskWrapper;
