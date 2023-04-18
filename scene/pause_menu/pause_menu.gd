extends Control

const HANDLER_NAME = "SceneHandler"

var Handler

var ResumeBtn
var OptionsBtn
var QuitBtn

func _ready():
	Handler = get_tree().get_root().get_node(HANDLER_NAME)
	_connect_itself()

func _connect_itself():
	$VBoxContainer/Resume.connect("pressed", self, "_on_resume_btn_pressed")
	$VBoxContainer/Options.connect("pressed", self, "_on_options_btn_pressed")
	$VBoxContainer/Quit.connect("pressed", self, "_on_quit_btn_pressed")
	
func __disconnect_itself():
	pass
	
#func _initialize_components():
#	ResumeBtn = $VBoxContainer/Resume
#	OptionsBtn = $VBoxContainer/Options
#	QuitBtn = $VBoxContainer/Quit

func _on_options_btn_pressed():
	Handler._plug_scene(Handler.PLUGGED_SCENE.options)
	
func _on_resume_btn_pressed():
	pass
	
func _on_quit_btn_pressed():
	Handler._quit_game()
