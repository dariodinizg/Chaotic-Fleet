extends Control

const HANDLER_NAME = "SceneHandler"

var Handler

var ResumeBtn
var OptionsBtn
var QuitBtn

func _ready():
	Handler = get_tree().get_root().get_node(HANDLER_NAME)

func connect_itself():
	pass
	
func disconnect_itself():
	pass
	
func initialize_components():
	ResumeBtn = $VBoxContainer/Resume
	OptionsBtn = $VBoxContainer/Quit
	QuitBtn = $VBoxContainer/Quit

func _on_options_btn_pressed():
	pass
	
func _on_resume_btn_pressed():
	pass
	
func _on_quit_btn_pressed():
	Handler._quit_game()
