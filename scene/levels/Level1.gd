extends Node


#Talvez transformar este script em um LevelHandler com os diversos nodes extendendo este escript

signal level_exited

const HANDLER_NAME = "LevelHandler"
var handler_node

var GameOverScene = preload("res://scene/game_over/game_over.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Music.play()
	_connect_itself(HANDLER_NAME)
	_connect_players_signals()


func _connect_players_signals():
	$Spaceship.connect("player_exploded", self, "on_player_exploded")

func on_player_exploded():
	var game_over_popup = GameOverScene.instance()
	add_child(game_over_popup)
	game_over_popup.visible = true

func _connect_itself(handler_name):
#	handler_node = get_tree().get_root().get_node(handler_name)
#	self.connect("level_exited", handler_node, "_on_level_exited")
	pass

func disconnect_itself():
	pass

func on_gameover_yes_btn_pressed():
	get_tree().reload_current_scene()
	
func on_gameover_no_btn_pressed():
	emit_signal("level_exited")

func _end_game():
	var game_over_popup = GameOverScene.instance()
	add_child(game_over_popup)
	game_over_popup.visible = true




