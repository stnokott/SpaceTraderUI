extends Node

var mp_peer = ENetMultiplayerPeer.new()

const SERVER_ADDR = "localhost"
const SERVER_PORT = 55555

# Called when the node enters the scene tree for the first time.
func _ready():
	var err = mp_peer.create_client(SERVER_ADDR, SERVER_PORT)
	print("create client: ", err)  # TODO: error handling
	multiplayer.connected_to_server.connect(self._on_connected)
	multiplayer.multiplayer_peer = mp_peer


func _on_connected() -> void:
	print("connected to server")
	var client_id: int = multiplayer.get_unique_id()
	print("id:", client_id)

@rpc("authority", "call_remote", "reliable")
func SetServerInfo(version: String, nextReset: String):
	print(version)
	print(nextReset)
