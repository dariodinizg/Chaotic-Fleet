class_name SceneHandler

extends Node2D

const PLUGGED_SCENES = {
	menu = preload("res://scene/main_menu/Menu.tscn"),
	options = preload("res://scene/options/Options.tscn"),
	game_over = preload("res://scene/game_over/game_over.tscn"),
	levels = {
		1 : preload("res://scene/levels/Level1.tscn")
	},
}

var current_plugged_scene
var previous_plugged_scene
var is_game_booting


func _ready():
	is_game_booting = true
	_plug_scene(PLUGGED_SCENES.menu)
	is_game_booting = false

func _on_gameover_no_btn_pressed():
	_plug_scene(PLUGGED_SCENES.menu)


func _free_current_plugged_scene():
	if $MarginContainer.get_children().size() != 0:
		if previous_plugged_scene != current_plugged_scene:
			previous_plugged_scene = current_plugged_scene
		_get_current_plugged_scene().disconnect_itself()
		return $MarginContainer.get_children()[0].queue_free()
	return


func _get_current_plugged_scene():
	return $MarginContainer.get_children()[0]


func _plug_scene(preloaded_scene):
	current_plugged_scene = preloaded_scene
	_free_current_plugged_scene()
	var scene_instance = preloaded_scene.instance()
	$MarginContainer.add_child(scene_instance)


#MENU SCENE SIGNALS
func _on_MenuScene_solo_game_btn_pressed():
# warning-ignore:return_value_discarded
#	get_tree().change_scene(levels[1])
	_plug_scene(PLUGGED_SCENES.levels[1])


func _on_MenuScene_game_exit_btn_pressed():
	get_tree().quit()


func _on_MenuScene_game_options_btn_pressed():
	_plug_scene(PLUGGED_SCENES.options)


#OPTIONS SCENE SIGNALS
func on_OptionsScene_back_btn_pressed():
	_plug_scene(PLUGGED_SCENES.menu)


#GAME OVER SCENE SIGNALS
func _on_gameover_yes_btn_pressed():
	_free_current_plugged_scene()
	_plug_scene(current_plugged_scene)




