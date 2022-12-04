class_name GameOverScene

extends Popup

const HANDLER_NAME = "SceneHandler"

var Handler
var gameover_yes_btn
var gameover_no_btn

func _ready():
#	gameover_yes_btn, gameover_no_btn = _initialize_components()
	_initialize_components()
	Handler = connect_itself(HANDLER_NAME)


func connect_itself(handler_name):
	var handler_node = get_tree().get_root().get_node(handler_name)
	gameover_yes_btn.connect("pressed", handler_node, "_on_gameover_yes_btn_pressed")
	gameover_no_btn.connect("pressed", handler_node, "_on_gameover_no_btn_pressed")
	return handler_node
	
func disconnect_itself():
	pass


func _initialize_components():
	gameover_yes_btn = $MarginContainer/VBoxContainer/HBoxContainer/popup_yes_btn
	gameover_no_btn = $MarginContainer/VBoxContainer/HBoxContainer/popup_no_btn
#	return [yes_btn, no_btn]
	
func _connect_btn(btn):
	pass
