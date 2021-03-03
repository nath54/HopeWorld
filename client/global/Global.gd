extends Node

############## WEBSOCKETS ##############

var ip = "127.0.0.1"#"192.168.1.53"
var port = 7896
var SOCKET_URL = "ws://"+ip+":"+str(port)
var joueur_id = null
var connection_key = null
var _client = WebSocketClient.new()

func _ready():
	_client.connect("connection_closed", self, "_on_connection_closed")
	_client.connect("connection_error", self, "_on_connection_error")
	_client.connect("connection_established", self, "_on_connected")
	_client.connect("data_received", self, "_on_data")
	
	var err = _client.connect_to_url(SOCKET_URL)
	if err != OK:
		print("Unable to connect to ", SOCKET_URL)
		set_process(false)

func _process(delta):
	_client.poll()

func _on_connection_error():
	print("There was an error")
	set_process(false)

func _on_connection_closed(was_clean = false):
	print("Closed, clean: ", was_clean)
	set_process(false)

func _on_connected(proto = ""):
	print("Connected with protocol: ", proto)

func _on_data():
	var data = JSON.parse(_client.get_peer(1).get_packet().get_string_from_utf8()).result
	# print("Received data: ", payload)
	analyse_data(data)

func _send(data, is_json=true):
	if is_json:
		data = JSON.print(data)
	_client.get_peer(1).put_packet(data.to_utf8())


func analyse_data(data):
	if "type" in data.keys():
		if data["type"] == "connection_error":
			alert("Error during connection", data["error"])
		elif data["type"] == "connection_accepted":
			joueur_id = data["id"]
			connection_key = data["key"]
			get_tree().change_scene("res://game/init.tscn")
		else:
			print("Unsupported action: ", data)
	else:
		print("Unsupported data: ",data)





############## INTERFACES ##############


func alert(titre, message):
	var res = load("res://menu/alert.tscn")
	var alerte = res.instance()
	alerte.titre.text = titre
	alerte.message.text = message
	get_tree().root.add_child(alerte)



############## JEU ##############



