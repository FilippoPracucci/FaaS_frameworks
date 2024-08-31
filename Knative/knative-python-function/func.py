from parliament import Context
from flask import Request
import json


# parse request body, json data or URL query parameters
def payload_print(req: Request) -> str:
    if req.is_json:
        data = req.get_json()
        file_bytes = bytes(json.dumps(data), "utf-8")

        return json.dumps({
            "data": data,
            "n. elements": len(data),
            "bytes": len(file_bytes)
        })
    else:
        # MultiDict needs some iteration
        ret = "{"

        for key in req.form.keys():
            ret += '"' + key + '": "'+ req.form[key] + '", '

        return ret[:-2] + "}\n" if len(ret) > 2 else "{}"


# pretty print the request to stdout instantaneously
def pretty_print(req: Request) -> str:
    ret = str(req.method) + ' ' + str(req.url) + ' ' + str(req.host) + '\n'
    for (header, values) in req.headers:
        ret += "  " + str(header) + ": " + values + '\n'

    if req.method == "POST":
        ret += "Request body:\n"
        ret += "  " + payload_print(req) + '\n'

    elif req.method == "GET":
        ret += "URL Query String:\n"
        ret += "  " + payload_print(req) + '\n'

    return ret


def main(context: Context):
    """
    Function template
    The context parameter contains the Flask request object and any
    CloudEvent received with the request.
    """

    # Add your business logic here
    print("Received request")

    if 'request' in context.keys():
        ret = pretty_print(context.request)
        print(ret, flush=True)
        return payload_print(context.request), 200
    else:
        print("Empty request", flush=True)
        return "{}", 200
