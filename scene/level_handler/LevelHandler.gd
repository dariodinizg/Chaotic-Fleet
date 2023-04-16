extends Node2D
class_name LevelHandler


const HANDLER_NAME = "SceneHandler"
var Handler

enum { ON_GAME, ON_PAUSE_MENU, ON_GAME_OVER }
var current_state
var current_plugged_scene
var is_state_starting := true

var current_level := 1
var is_level_starting := true

func _ready():
	Handler = get_tree().get_root().get_node(HANDLER_NAME)
	current_state = ON_GAME

func _process(delta):
	_behave()


const LEVELS = {
	1: preload("res://scene/levels/Level1.tscn"),
	2: ""
}

func _behave():
	match current_state:
		ON_GAME:
			_on_game()
		ON_PAUSE_MENU:
			_on_pause_menu()
		ON_GAME_OVER:
			_on_game_over()
		

func _on_game():
	if is_state_starting:
		if is_level_starting:
			Handler._plug_scene(LEVELS[current_level])
		else:
			pass
	
func _on_game_over():
	if is_state_starting:
		Handler._plug_scene(Handler.PLUGGED_SCENES.game_over)
	
func _on_pause_menu():
	if is_state_starting:
		Handler._plug_scene(Handler.PLUGGED_SCENES.pause_menu)

func _plug_level():
	pass

func _end_game():
	pass

func check_current_state():
	pass

func listen_pause_input():
	if Input.is_action_just_pressed("ui_cancel"):
		current_state = _set_state(ON_PAUSE_MENU)


func _set_state(state):
	if state != current_state:
		is_state_starting = true
	else:
		is_state_starting = false
	return current_state
	

func _set_level(level_number):
	if level_number != current_level:
		is_level_starting = true
	else:
		is_level_starting = false
	return level_number
	
func disconnect_itself():
	pass
