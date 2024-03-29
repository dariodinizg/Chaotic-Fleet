class_name MainMenu

extends Control

const HANDLER_NAME = "SceneHandler"

var Handler
var is_musicOn = true
var currentSongPosition : float
var game_settings = ConfigHandler.game_settings


func _ready():
	Handler = get_tree().get_root().get_node(HANDLER_NAME)
	_connect_itself()
	$CanvaMenu/music.volume_db = game_settings.menu.musicVol
	if game_settings.menu.is_musicOn:
		if Handler.is_game_booting:
			$CanvaMenu/music.play()
		else:
			$CanvaMenu/music.play(game_settings.menu.currentSongPosition)
	elif game_settings.menu.musicVol <= -40:
		$CanvaMenu/music.stop()
		$CanvaMenu/muteBtn.pressed = true
	else:
		$CanvaMenu/muteBtn.pressed = true

func _disconnect_itself():
	game_settings.menu.currentSongPosition = $CanvaMenu/music.get_playback_position()


func _connect_itself():
	# BTNs
# warning-ignore:return_value_discarded
	$CanvaMenu/VBoxContainer/options_btn.connect("pressed", self, "_on_options_btn_pressed")
# warning-ignore:return_value_discarded
	$CanvaMenu/VBoxContainer/exit_btn.connect("pressed", self, "_on_exit_btn_pressed")
# warning-ignore:return_value_discarded
	$CanvaMenu/VBoxContainer/solo_game_btn.connect("pressed", self, "_on_solo_game_btn_pressed")


func _on_solo_game_btn_pressed():
	Handler._plug_scene("level_handler")

func _on_exit_btn_pressed():
	Handler._quit_game()
	
func _on_options_btn_pressed():
	Handler._plug_scene("options")
	
func _on_MenuScene_game_exit_btn_pressed():
	get_tree().quit()
	
func _on_muteBtn_pressed():
	print("just booted:",Handler.is_game_booting)
	if game_settings.menu.is_musicOn:
		game_settings.menu.currentSongPosition = $CanvaMenu/music.get_playback_position()
		game_settings.menu.is_musicOn = 0
		$CanvaMenu/music.stream_paused =  true
	else:
		game_settings.menu.is_musicOn = 1
		change_musicPlayer_state()

func change_musicPlayer_state():
	if $CanvaMenu/music.stream_paused == true:
		$CanvaMenu/music.stream_paused =  false
	else:
		$CanvaMenu/music.play()
	



#func _on_MenuScene_game_options_btn_pressed():
#	Handler._plug_scene(Handler.PLUGGED_SCENES.options)
