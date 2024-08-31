'use strict'

module.exports = async (event, context) => {
	let data = JSON.parse(Object.keys(event.body).pop());

	const result = {
		"data": data,
		"n. elements": Object.keys(data).length,
		"bytes": Buffer.byteLength(JSON.stringify(data))
	}

	return context
		.status(200)
		.succeed(result)
}
