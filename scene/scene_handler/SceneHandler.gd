class_name SceneHandler
extends Node2D

# This node is responsible for transitioning scenes and keep game states like ON_MENU, ON_GAME.


const PLUGGED_SCENES = {
	# Plug each scene of the game this handler is responsible for
	
	menu = preload("res://scene/main_menu/Menu.tscn"),
	options = preload("res://scene/options/Options.tscn"),
	game_over = preload("res://scene/game_over/game_over.tscn"),
	pause_menu = preload("res://scene/pause_menu/pause_menu.tscn"),
	level_handler = preload("res://scene/level_handler/LevelHandler.tscn"),
}

enum { ON_GAME, ON_MAINMENU, ON_OPTIONS, ON_PAUSEMENU } # A ser implementado
var current_state

var current_plugged_scene
var previous_plugged_scene
var is_game_booting


func _ready():
	is_game_booting = true
	_plug_scene("menu")
	is_game_booting = false

func _on_gameover_no_btn_pressed():
#	_plug_scene(PLUGGED_SCENES.menu)
	_plug_scene("menu")


func _free_current_plugged_scene(_current_plugged_scene):
	if has_previous_scene():
		previous_plugged_scene = _check_previous_plugged_scene(_current_plugged_scene)
		_get_current_plugged_scene().disconnect_itself()
		return $SceneContainer.get_children()[0].queue_free()


func _check_previous_plugged_scene(_current_plugged_scene):
	if previous_plugged_scene != current_plugged_scene:
		return current_plugged_scene


func _get_current_plugged_scene():
	return $SceneContainer.get_children()[0]


func has_previous_scene():
	if $SceneContainer.get_children().size() != 0:
		return true
	return false


func _plug_scene(scene_name):
	var preloaded_scene = PLUGGED_SCENES[scene_name]
	current_plugged_scene = preloaded_scene
	match scene_name:
		"menu":
			current_state = ON_MAINMENU
		"pause_menu":
			current_state = ON_PAUSEMENU
		"level_handler":
			current_state = ON_GAME
	_free_current_plugged_scene(current_plugged_scene)
	var scene_instance = preloaded_scene.instance()
#	if _preloaded_scene == PLUGGED_SCENES.level_handler:
#		add_child(scene_instance)
#	else:
	$SceneContainer.add_child(scene_instance)


func _quit_game():
	GameHandler.saveConfig()
	get_tree().quit()




