import json

def handle(event, context):

    data = json.loads(event.body.decode())
    file_bytes = bytes(json.dumps(data), "utf-8")

    return {
        "statusCode": 200,
        "body": {
            "data": data,
            "n. elements": len(data),
            "bytes": len(file_bytes)
        }
    }
