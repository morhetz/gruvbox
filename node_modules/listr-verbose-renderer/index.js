'use strict';
const figures = require('figures');
const cliCursor = require('cli-cursor');
const utils = require('./lib/utils');

const renderHelper = (task, event) => {
	if (event.type === 'STATE') {
		const message = task.isPending() ? 'started' : task.state;

		utils.log(`${task.title} [${message}]`);

		if (task.isSkipped() && task.output) {
			utils.log(`${figures.arrowRight} ${task.output}`);
		}
	} else if (event.type === 'DATA') {
		utils.log(`${figures.arrowRight} ${event.data}`);
	} else if (event.type === 'TITLE') {
		utils.log(`${task.title} [title changed]`);
	}
};

const render = tasks => {
	for (const task of tasks) {
		task.subscribe(
			event => {
				if (event.type === 'SUBTASKS') {
					render(task.subtasks);
					return;
				}

				renderHelper(task, event);
			},
			err => {
				console.log(err);
			}
		);
	}
};

class VerboseRenderer {

	constructor(tasks) {
		this._tasks = tasks;
	}

	static get nonTTY() {
		return true;
	}

	render() {
		cliCursor.hide();
		render(this._tasks);
	}

	end() {
		cliCursor.show();
	}
}

module.exports = VerboseRenderer;
