extends Node2D

#var mainmenu = preload("res://scene/MainMenu/Menu.tscn")
var configFile = "config.json"
var configuration

const PLUGGED_SCENES = {
	menu = preload("res://scene/main_menu/Menu.tscn"),
	options = preload("res://scene/options/Options.tscn")
}

export var is_game_just_booted = true

const levels = {
	1:"res://scene/sevels/Level1.tscn"
}

func _ready():
	_plug_scene(PLUGGED_SCENES.menu)
	is_game_just_booted = false
	

#MENU SCENE SIGNALS
func _on_MenuScene_solo_game_btn_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scene/levels/Level1.tscn")

func _on_MenuScene_game_exit_btn_pressed():
	print("end game")
	get_tree().quit()

func _on_MenuScene_game_options_btn_pressed():
	_plug_scene(PLUGGED_SCENES.options)
	
#OPTIONS SCENE SIGNALS
func on_OptionsScene_back_btn_pressed():
	_plug_scene(PLUGGED_SCENES.menu)


func _free_current_plugged_scene():
	if $MarginContainer.get_children().size() != 0:
		$MarginContainer.get_children()[0].disconnect_itself()
		return $MarginContainer.get_children()[0].queue_free()
	return


func _plug_scene(preloaded_scene):
	_free_current_plugged_scene()
	var scene_instance = preloaded_scene.instance()
	$MarginContainer.add_child(scene_instance)
	
