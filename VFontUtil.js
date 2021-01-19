#!/usr/bin/env node

const fs = require("fs");
const cp = require("child_process");

fs.exists("./fonts", (err, exists) => {
	if (err) throw err;
	if (!exists) {
		fs.mkdir("./fonts", (err) => {
			if (err) throw err;
			cp.exec(`cd ${__dirname}/fonts; wget -O Montserrat.tff https://github.com/77Z/Shadow-Engine/blob/master/fonts/Montserrat-SemiBold.tff?raw=true`, (error, stderr, stdout) => {
				if (error) throw error;
				if (stderr) throw stderr;
				console.log(stdout);
				installf();
			});
		});
	} else {
		installf();
	}
});

function installf() {
	
}
