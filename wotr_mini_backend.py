import os
import sqlite3
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
	sql_q = f"SELECT * FROM players WHERE network_id = '{network_id}'"
	result = db_cursor.execute(sql_q).fetchone()
	inc_strings = ["coins", "headshots_with_crossbow, experience", "revives", "squad_spawns", "anti_cheat_connects", "anti_cheat_kicks", "anti_cheat_status_authenticated", "anti_cheat_status_banned", "anti_cheat_status_disconnected"]
	if result == None:
		sql_q = f"INSERT INTO players VALUES ('{network_id}',0,0,0,0,0,0,0,false,0,0,0,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)"
		db_cursor.execute(sql_q)
	for x in stats:
		values = x.split("=")
		if values[0] in inc_strings:
			sql_q = f"UPDATE players SET '{values[0]}' = {values[0]} + '{values[1]}' WHERE network_id = '{network_id}'"
		else:
			sql_q = f"UPDATE players SET '{values[0]}' = '{values[1]}' WHERE network_id = '{network_id}'"
		db_cursor.execute(sql_q)
	db.commit()
	sql_q = f"SELECT * FROM players WHERE network_id = '{network_id}'"
	row = db_cursor.execute(sql_q)
	column_names = list(map(lambda x: x[0], row.description))
	column_values = row.fetchall()[0]
	with open("loadstats/" + network_id, "w") as write_stats:
		for x in range(len(column_names))[1:]:
			if column_values[x] == None:
				continue
			else:
				write_stats.write(column_names[x] + "=" + column_values[x] + " ")

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
			save(stats_string[1],stats_string[2].split(";")[:-1])


if not os.path.exists("loadstats"):
    os.makedirs("loadstats")
    
db_file = "wotr.db"
if os.path.isfile(db_file):
	db = sqlite3.connect(db_file)
	db_cursor = db.cursor()
else:
	db = sqlite3.connect(db_file)
	db_cursor = db.cursor()
	db_cursor.execute('CREATE TABLE players (network_id text, anti_cheat_connects text, anti_cheat_kicks text, anti_cheat_status_authenticated text, anti_cheat_status_banned text, anti_cheat_status_disconnected text, coins text, coins_unlocked_100k text, coins_unlocked_50k text, experience text, headshots_with_crossbow text, last_win_time text, medal_anti_cavalry text, medal_assist text, medal_bastard_sword text, medal_bow text, medal_bronze_grand text, medal_conquest text, medal_conquest_winner text, medal_corporal_punishment text, medal_crossbow text, medal_dagger text, medal_executioner text, medal_gold_grand text, medal_horse_killer text, medal_lance text, medal_marksman text, medal_medical_efficiency text, medal_mounted_warfare text, medal_one_handed_axe text, medal_one_handed_club text, medal_one_handed_sword text, medal_polearm text, medal_premium_squad text, medal_reconoiter_efficiency text, medal_silver_grand text, medal_spawner text, medal_spear text, medal_squad_spawn text, medal_squad_wipe text, medal_surgery_efficiency text, medal_team_deathmatch text, medal_team_deathmatch_winner text, medal_two_handed_axe text, medal_two_handed_club text, medal_two_handed_sword text, prize_anti_cavalry text, prize_assist text, prize_bastard_sword text, prize_bow text, prize_bronze_grand text, prize_conquest text, prize_conquest_winner text, prize_corporal_punishment text, prize_crossbow text, prize_dagger text, prize_executioner text, prize_gold_grand text, prize_horse_killer text, prize_lance text, prize_marksman text, prize_medical_efficiency text, prize_mounted_warfare text, prize_one_handed_axe text, prize_one_handed_club text, prize_one_handed_sword text, prize_polearm text, prize_premium_squad text, prize_reconoiter_efficiency text, prize_silver_grand text, prize_spear text, prize_squad_spawn text, prize_squad_wipe text, prize_surgery_efficiency text, prize_team_deathmatch text, prize_team_deathmatch_winner text, prize_two_handed_axe text, prize_two_handed_club text, prize_two_handed_sword text, revives text, squad_spawns text)')
	db_cursor.execute('CREATE INDEX indx ON players("network_id")')

run()

#db.commit()
#db.close()
