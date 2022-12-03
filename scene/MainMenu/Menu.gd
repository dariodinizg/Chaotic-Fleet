class_name MainMenu

extends Control

signal solo_game_btn_pressed
signal game_exit_btn_pressed
signal options_btn_pressed

const HANDLER_NAME = "SceneHandler"

var Handler
var is_musicOn = true
var currentSongPosition : float
var game_settings = GameHandler.game_settings


func _ready():
	Handler = connect_itself(HANDLER_NAME)
	$CanvaMenu/music.volume_db = game_settings.menu.musicVol
	if game_settings.menu.is_musicOn:
		if Handler.is_game_just_booted and game_settings.menu.is_musicOn:
			$CanvaMenu/music.play()
		else:
			$CanvaMenu/music.play(game_settings.menu.currentSongPosition)
	elif game_settings.menu.musicVol <= -40:
		$CanvaMenu/music.stop()
		$CanvaMenu/muteBtn.pressed = true
	else:
		$CanvaMenu/muteBtn.pressed = true

func disconnect_itself():
	game_settings.menu.currentSongPosition = $CanvaMenu/music.get_playback_position()
	GameHandler.saveJSONConfig()


func connect_itself(handler_name):
	# Searches the tree for the handler node name and connects its signals.
	# Returns its handler node.
	
	var handler_node = get_tree().get_root().get_node(handler_name)
# warning-ignore:return_value_discarded
	self.connect("options_btn_pressed", handler_node, "_on_MenuScene_game_options_btn_pressed")
# warning-ignore:return_value_discarded
	self.connect("solo_game_btn_pressed", handler_node, "_on_MenuScene_solo_game_btn_pressed")
# warning-ignore:return_value_discarded
	self.connect("game_exit_btn_pressed", handler_node, "_on_MenuScene_game_exit_btn_pressed")
	return handler_node


func _on_solo_game_btn_pressed():
	emit_signal("solo_game_btn_pressed")

func _on_exit_btn_pressed():
	GameHandler.saveJSONConfig()
	emit_signal("game_exit_btn_pressed")
	
func _on_options_btn_pressed():
	emit_signal("options_btn_pressed")
	
func _on_muteBtn_pressed():
	if game_settings.menu.is_musicOn:
		currentSongPosition = $CanvaMenu/music.get_playback_position()
		$CanvaMenu/music.stop()
		game_settings.menu.is_musicOn = 0
	else:
		$CanvaMenu/music.play(currentSongPosition)
		game_settings.menu.is_musicOn = 1
		



