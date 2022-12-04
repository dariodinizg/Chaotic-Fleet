class_name OptionsScene

extends Control

# Name of the node that receives this one.
const HANDLER_NAME = "SceneHandler"

# Singleton with game settings
var game_settings = GameHandler.game_settings

var Handler
var MenuMusicVolBar
var SfxVolBar
var SfxLoopTimer
var GameVolBar

var current_song_position
var is_game_music_vol_changed = false
var is_menu_music_vol_changed = false
var is_sfx_vol_changed = false

signal OPTIONS_back_btn_pressed

func _ready():
#	[MenuMusicVolBar, SfxVolBar, GameVolBar] = _initialize_components()
	_initialize_components()
	_load_startup_settings()
	Handler = _connect_itself(HANDLER_NAME)


func _connect_itself(handler_name):
	# Searches the tree for the handler node name and connects its signals.
	# Returns its handler node.
	
	var handler_node = get_tree().get_root().get_node(handler_name)
	# warning-ignore:return_value_discarded
	self.connect("OPTIONS_back_btn_pressed", handler_node, "on_OptionsScene_back_btn_pressed")
	return handler_node

func _initialize_components():
	MenuMusicVolBar = $MarginContainer/VBoxContainer/MenuMusicSlider/MenuMusicVolSlider
	SfxVolBar = $MarginContainer/VBoxContainer/SoundEffects/SFXVolSlider
	SfxLoopTimer = $MarginContainer/VBoxContainer/SoundEffects/SfxLoopTimer
	GameVolBar = $MarginContainer/VBoxContainer/GameMusic/GameMusicVolSlider
#	return [MenuMusicVolBar, SfxVolBar, GameVolBar]

func _load_startup_settings():
	current_song_position = game_settings.menu.currentSongPosition
	if game_settings.menu.is_musicOn == 1:
		$MenuMusic.volume_db = game_settings.menu.musicVol
		$MenuMusic.play(current_song_position)
	MenuMusicVolBar.value = game_settings.menu.musicVol
	SfxVolBar.value = game_settings.game.sfxVol
	GameVolBar.value = game_settings.game.bgMusic
		

func disconnect_itself():
	game_settings.menu.currentSongPosition = $MenuMusic.get_playback_position()
	GameHandler.saveConfig()


func _on_back_btn_pressed():
	disconnect_itself()
	emit_signal("OPTIONS_back_btn_pressed")


func _on_popup_no_btn_pressed():
	emit_signal("OPTIONS_back_btn_pressed")


func _on_MenuMusicVolSlider_value_changed(value):
#	if is_game_music_vol_changed:
	if MenuMusicVolBar.value > -20.0:
		$MenuMusic.stream_paused = false
		game_settings.menu.is_musicOn = 1
		$MenuMusic.volume_db = MenuMusicVolBar.value
	else:
		game_settings.menu.is_musicOn = 0
		$MenuMusic.stream_paused = true


func _on_MenuMusicVolSlider_drag_started():
	if game_settings.menu.is_musicOn == 0:
		 game_settings.menu.is_musicOn = 1
	if $MenuMusic.playing == false:
		$MenuMusic.playing = true
	else:
		$MenuMusic.volume_db = MenuMusicVolBar.value


func _on_MenuMusicVolSlider_drag_ended(value_changed):
	game_settings.menu.musicVol = MenuMusicVolBar.value
	if $MenuMusic.playing == false:
		game_settings.menu.is_musicOn = 0


func _on_SFXVolumeSlider_value_changed(value):
	if SfxVolBar.value >= -35:
		if is_sfx_vol_changed:
			$Sfx.volume_db = SfxVolBar.value


func _on_SFXVolSlider_drag_started():
	$MenuMusic.stream_paused = true
	is_sfx_vol_changed = true
	SfxLoopTimer.wait_time = 1
	SfxLoopTimer.start()


func _on_SFXVolSlider_drag_ended(value_changed):
	game_settings.game.sfxVol = SfxVolBar.value
	SfxLoopTimer.stop()
	$Sfx.stop()
	$MenuMusic.stream_paused = false


func _on_SfxLoopTimer_timeout():
	$Sfx.play()


func _on_GameMusicVolSlider_value_changed(value):
	if GameVolBar.value >= -18:
		$GameMusic.volume_db = GameVolBar.value - 4.0
	else:
		$GameMusic.stop()


func _on_GameMusicVolSlider_drag_started():
	$MenuMusic.stream_paused = true
	$GameMusic.play()


func _on_GameMusicVolSlider_drag_ended(value_changed):
	$GameMusic.stop()
	$MenuMusic.stream_paused = false
	game_settings.game.bgMusic = GameVolBar.value






