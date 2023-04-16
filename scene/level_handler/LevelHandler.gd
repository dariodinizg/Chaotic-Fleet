extends Node2D

var current_state
var current_plugged_scene

const PLUGGED_SCENES = {
	game_over = preload("res://scene/game_over/game_over.tscn"),
	levels = {
		1:"res://scene/levels/Level1.tscn",
		2:""
	},
	pause_menu = preload("res://scene/pause_menu/pause_menu.tscn")
}

func _ready():
	pass

func _plug_level():
	pass

func _end_game():
	pass

func check_current_state():
	pass
