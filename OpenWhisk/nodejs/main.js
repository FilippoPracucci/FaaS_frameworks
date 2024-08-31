function main(args) {
    return {
        "data": args,
		"n. elements": Object.keys(args).length,
		"bytes": Buffer.byteLength(JSON.stringify(args))
    }
}
