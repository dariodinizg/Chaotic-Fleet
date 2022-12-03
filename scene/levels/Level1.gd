extends Node


var GameOverScene = preload("res://scene/game_over/game_over.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Music.play()
	_connect_players_signals()

func _connect_players_signals():
	$Spaceship.connect("player_exploded", self, "on_player_exploded")

func on_player_exploded():
	var popup = GameOverScene.instance()
	add_child(popup)
