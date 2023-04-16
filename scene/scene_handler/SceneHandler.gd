class_name SceneHandler
extends Node2D

# This node is responsible for transitioning scenes and keep game states like ON_MENU, ON_GAME.


const PLUGGED_SCENES = {
	# Plug each scene of the game this handler is responsible for
	
	menu = preload("res://scene/main_menu/Menu.tscn"),
	options = preload("res://scene/options/Options.tscn"),
	game_over = preload("res://scene/game_over/game_over.tscn"),
	levels = {
		1 : preload("res://scene/levels/Level1.tscn")
	},
}

enum { ON_GAME, ON_MAINMENU, ON_OPTIONS } # A ser implementado

var current_plugged_scene
var previous_plugged_scene
var is_game_booting


func _ready():
	is_game_booting = true
	_plug_scene(PLUGGED_SCENES.menu)
	is_game_booting = false

func _on_gameover_no_btn_pressed():
	_plug_scene(PLUGGED_SCENES.menu)


func _free_current_plugged_scene(_current_plugged_scene):
	if has_previous_scene():
		previous_plugged_scene = _check_previous_plugged_scene(_current_plugged_scene)
		_get_current_plugged_scene().disconnect_itself()
		return $MarginContainer.get_children()[0].queue_free()


func _check_previous_plugged_scene(_current_plugged_scene):
	if previous_plugged_scene != current_plugged_scene:
		return current_plugged_scene


func _get_current_plugged_scene():
	return $MarginContainer.get_children()[0]


func has_previous_scene():
	if $MarginContainer.get_children().size() != 0:
		return true
	return false


func _plug_scene(_preloaded_scene):
	current_plugged_scene = _preloaded_scene
	_free_current_plugged_scene(current_plugged_scene)
	var scene_instance = _preloaded_scene.instance()
	$MarginContainer.add_child(scene_instance)


func _quit_game():
	GameHandler.saveConfig()
	get_tree().quit()

#func _check_config_keys():
#	if Input.is_action_just_pressed("ui_cancel"):
#		if current_state == ON_GAME:
#			_plug_scene(PLUGGED_SCENES.options)


