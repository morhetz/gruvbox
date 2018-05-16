'use strict';
const chalk = require('chalk');

const pad = n => n < 10 ? `0${n}` : n;

const currentTime = () => {
	const now = new Date();

	return pad(now.getHours()) + ':' + pad(now.getMinutes()) + ':' + pad(now.getSeconds());
};

exports.log = output => {
	console.log(chalk.dim(`[${currentTime()}]`) + ` ${output}`);
};
