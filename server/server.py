
import socket
import _thread
import json

class Server:
    def __init__(self):
        
        with open('config.json') as json_file:
            data = json.load(json_file)
            self.host = data["host"]
            self.port = data["port"]
            self.max_size = data["max_size"]
            self.version = data["version"]
        self.clients = {}
        self.server = None

    def main(self):
        pass

if __name__ == "__main__":
    server = Server()
    server.main()

