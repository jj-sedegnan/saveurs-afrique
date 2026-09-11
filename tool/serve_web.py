#!/usr/bin/env python3
"""Petit serveur statique pour la version web compilée (build/web).

Toute route qui ne correspond pas à un fichier est renvoyée vers
index.html, afin que la navigation côté client (GoRouter) fonctionne aussi
après un rechargement sur une sous-route.

Usage : python3 tool/serve_web.py [port]
"""
import http.server
import os
import sys

PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8080
WEB_DIR = os.path.join(os.path.dirname(__file__), "..", "build", "web")


class SPARequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=WEB_DIR, **kwargs)

    def do_GET(self):
        path = self.translate_path(self.path)
        # Si la ressource n'existe pas (route cliente), servir index.html.
        if not os.path.exists(path) and not self.path.startswith("/assets"):
            self.path = "/index.html"
        return super().do_GET()

    def end_headers(self):
        # Pas de cache pendant la démo.
        self.send_header("Cache-Control", "no-store")
        super().end_headers()

    def log_message(self, fmt, *args):
        sys.stderr.write("[web] %s\n" % (fmt % args))


if __name__ == "__main__":
    server = http.server.ThreadingHTTPServer(("0.0.0.0", PORT), SPARequestHandler)
    print(f"Serveur SPA sur http://0.0.0.0:{PORT} (racine : {WEB_DIR})")
    server.serve_forever()
