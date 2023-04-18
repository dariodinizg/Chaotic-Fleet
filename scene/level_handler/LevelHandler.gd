extends Node2D
class_name LevelHandler


const HANDLER_NAME = "SceneHandler"
var Handler

enum { ON_GAME, ON_PAUSE_MENU, ON_GAME_OVER }
var current_state
var current_plugged_scene
var is_state_starting := true

var current_level := 1
var previous_level
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
			_plug_level(1)
			is_level_starting = false
		else:
			pass
	
func _on_game_over():
	if is_state_starting:
		Handler._plug_scene(Handler.PLUGGED_SCENES.game_over)
	
func _on_pause_menu():
	if is_state_starting:
		Handler._plug_scene(Handler.PLUGGED_SCENES.pause_menu)

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
	
func _disconnect_itself():
	pass


func _free_current_plugged_level(_current_plugged_level):
	if has_previous_scene():
		previous_level = _check_previous_plugged_level(_current_plugged_level)
		_get_current_plugged_scene()._disconnect_itself()
		return $LevelContainer.get_children()[0].queue_free()


func _check_previous_plugged_level(_current_level):
	if previous_level != current_level:
		return current_level


func _get_current_plugged_scene():
	return $LevelContainer.get_children()[0]


func has_previous_scene():
	if $LevelContainer.get_children().size() != 0:
		return true
	return false


func _plug_level(level_number):
	current_level = level_number
	var preloaded_level = LEVELS[level_number]
#	match current_plugged_scene:
#		PLUGGED_SCENES.menu:
#			current_state = ON_MAINMENU
#		PLUGGED_SCENES.pause_menu:
#			current_state = ON_PAUSEMENU
#		PLUGGED_SCENES.level_handler:
#			current_state = ON_GAME
	_free_current_plugged_level(current_level)
	var level_instance = preloaded_level.instance()
	$LevelContainer.add_child(level_instance)
