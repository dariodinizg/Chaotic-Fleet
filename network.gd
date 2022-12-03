extends Node

const IP_STANDARD = "127.0.0.1"
const SERVER_PORT = 6007
const SERVER_MAX_PLAYERS = 4

var ip = IP_STANDARD
var host_name = "Jogador"
var connection_id = ""
var players_list = []
var peer = null

#var ip = IP.get_local_addresses()[0]

func _ready():
	get_tree().connect("connected_to_server",self,"_connected_to_server_handler")
	get_tree().connect("server_disconnected", self, "_server_disconnected_handler")
	get_tree().connect("connection_failed", self, "_connection_failed_handler")
	players_list.clear()
	 

func _connected_to_server_handler(player_name):
	rpc("_player_registration", get_tree().get_network_unique_id(), player_name)
	
	
func _server_disconnected_handler():
	get_tree().quit()
	
func _connection_failed_handler():
	pass
	
func peer_disconnected_handler(player_id):
	rpc("_logout_player", player_id)
	

remote func _player_registration(player_id, player_name):
	if get_tree().is_network_server():
		for i in range(players_list.size()):
			rpc_id(player_id, "_player_registration", players_list[i][0], players_list[i][1])
		rpc("_player_registration", player_id, player_name)
	players_list.append(player_id, player_name)


remotesync func _logout_player(player_id):
	for i in range(players_list.size()):
		if player_id == players_list[i][0]:
			players_list.remove(i)
	
func _create_server():
	peer = NetworkedMultiplayerENet.new()
	peer.create_server(SERVER_PORT, SERVER_MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	connection_id = get_tree().get_network_unique_id()
	peer.connect("peer_disconnected", self, "peer_disconnected_handler")

func _enter_server():
	peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, SERVER_PORT)
	get_tree().set_network_peer(peer)
	connection_id = get_tree().get_network_unique_id()
