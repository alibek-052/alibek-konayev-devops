#!/usr/bin/env python3
"""DevOps Student Application.

Prints the student information (taken from environment variables) and then
starts a tiny HTTP server, so the container keeps running and can be
inspected with `docker ps`, `docker logs`, `docker exec`.
"""
import os
import signal
import sys
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT = int(os.environ.get("APP_PORT", "5000"))


def banner() -> str:
    env = os.environ.get
    return "\n".join([
        "================================",
        "DevOps Student Application",
        "================================",
        "",
        f"Name: {env('STUDENT_NAME', 'N/A')}",
        f"Surname: {env('STUDENT_SURNAME', 'N/A')}",
        f"Group: {env('STUDENT_GROUP', 'N/A')}",
        f"Student ID: {env('STUDENT_ID', 'N/A')}",
        "",
        "Application is running successfully!",
    ])


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        body = (banner() + "\n").encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, fmt, *args):
        print("[http] " + fmt % args, flush=True)


def stop(signum, frame):
    # PID 1 in a container ignores SIGTERM by default; handle it so that
    # `docker stop` finishes immediately instead of waiting 10 seconds.
    print("Application stopped.", flush=True)
    sys.exit(0)


if __name__ == "__main__":
    signal.signal(signal.SIGTERM, stop)
    signal.signal(signal.SIGINT, stop)
    print(banner(), flush=True)
    print(f"\nListening on port {PORT} ...", flush=True)
    HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()
