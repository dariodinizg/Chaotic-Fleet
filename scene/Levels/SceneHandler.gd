extends Node2D

#var mainmenu = preload("res://scene/MainMenu/Menu.tscn")
var configFile = "config.json"
var configuration

const PLUGGED_SCENES = {
	menu = preload("res://scene/MainMenu/Menu.tscn"),
	options = preload("res://scene/Options/Options.tscn")
}

export var is_game_just_booted = true

const levels = {
	1:"res://scene/Levels/Level1.tscn"
}

func _ready():
	plug_menu_scene()
	is_game_just_booted = false
	

#MENU SCENE SIGNALS
func _on_MenuScene_solo_game_btn_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scene/Levels/Level1.tscn")

func _on_MenuScene_game_exit_btn_pressed():
	print("end game")
	get_tree().quit()

func _on_MenuScene_game_options_btn_pressed():
	plug_options_scene()
	
#OPTIONS SCENE SIGNALS
func on_OptionsScene_back_btn_pressed():
	plug_menu_scene()


func free_current_plugged_scene():
	if $MarginContainer.get_children().size() != 0:
		$MarginContainer.get_children()[0].disconnect_itself()
		return $MarginContainer.get_children()[0].queue_free()
	return

func plug_menu_scene():
	free_current_plugged_scene()
	var mainMenu = PLUGGED_SCENES.menu.instance()
	$MarginContainer.add_child(mainMenu)
	
func plug_options_scene():
	free_current_plugged_scene()
	var optionsScene = PLUGGED_SCENES.options.instance()
	$MarginContainer.add_child(optionsScene)
