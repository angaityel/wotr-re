import os
from http.server import BaseHTTPRequestHandler
from http.server import HTTPServer

def run(server_class=HTTPServer, handler_class=BaseHTTPRequestHandler):
	server_address = ('127.0.0.1', 27844)
	httpd = server_class(server_address, HttpGetHandler)
	try:
		httpd.serve_forever()
	except KeyboardInterrupt:
		httpd.server_close()

def save(network_id, stats):
	if os.path.isfile("loadstats/" + network_id):
		stats_for_save_list = stats.split(";")[:-1]
		stats_dict = {}
		with open("loadstats/" + network_id, "r") as load_stats:
			local_stats = load_stats.read().split(" ")[:-1]
			for x in local_stats:
				(key, val) = x.split("=")
				stats_dict[key] = val
			for x in stats_for_save_list:
				values = x.split("=")
				if values[0] in stats_dict and values[0] in inc_strings:
					stats_dict[values[0]] = int(stats_dict[values[0]]) + int(values[1])
				else:
					stats_dict[values[0]] = values[1]
		with open("loadstats/" + network_id, "w") as write_stats:
			for k, v in stats_dict.items():
				write_stats.write(k + "=" + str(v) + " ")

	else:
		with open("loadstats/" + network_id, "w") as write_stats:
			write_stats.write(stats.replace(";", " "))

class HttpGetHandler(BaseHTTPRequestHandler):
	def do_GET(self):
		self.send_response(200)
		self.end_headers()

		if "/loadstats/" in self.path:
			try:
				with open(self.path[1:], "rb") as load_stats:
					self.wfile.write(load_stats.read())
			except FileNotFoundError:
				self.wfile.write(b"404")
		elif "/savestats/" in self.path:
			stats_string = self.path[1:].split("/")
			save(stats_string[1], stats_string[2])


if not os.path.exists("loadstats"):
	os.makedirs("loadstats")

inc_strings = ["coins", "headshots_with_crossbow", "experience", "revives", "squad_spawns", "anti_cheat_connects", "anti_cheat_kicks", "anti_cheat_status_authenticated", "anti_cheat_status_banned", "anti_cheat_status_disconnected"]

run()
