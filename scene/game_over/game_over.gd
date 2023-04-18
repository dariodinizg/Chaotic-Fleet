class_name GameOverScene

extends Popup

const HANDLER_NAME = "SceneHandler"

var Handler
var GameOverYesBtn
var GameOverNoBtn
var counter :=0

func _ready():
#	gameover_yes_btn, gameover_no_btn = _initialize_components()
	_initialize_components()
	Handler = get_tree().get_root().get_node(HANDLER_NAME)
	_connect_itself()


func _connect_itself():
	GameOverYesBtn.connect("pressed", self, "_on_gameover_yes_btn_pressed")
	GameOverNoBtn.connect("pressed", self, "_on_gameover_no_btn_pressed")
	
	
func _disconnect_itself():
	pass
	
	
func _on_gameover_yes_btn_pressed():
	Handler._plug_scene("level_handler")

func _on_gameover_no_btn_pressed():
	Handler._plug_scene("menu")

func _initialize_components():
	GameOverYesBtn = $MarginContainer/VBoxContainer/HBoxContainer/popup_yes_btn
	GameOverNoBtn = $MarginContainer/VBoxContainer/HBoxContainer/popup_no_btn
	
