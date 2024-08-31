import json

def main(args):
    file_bytes = bytes(json.dumps(args), "utf-8")

    return {
        "data": args,
        "n. elements": len(args),
        "bytes": len(file_bytes)
    }