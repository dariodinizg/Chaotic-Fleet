extends Node2D

var game_settings
var configFile = "game_settings"

func _ready():
	game_settings = loadConfigFile()

func loadConfigFile():
	var file = File.new()
	file.open(configFile, File.READ)
	var configInfo = str2var(file.get_as_text())
	file.close()
	return configInfo

func saveConfig():
	var file = File.new()
	file.open(configFile, File.WRITE)
	file.store_string(var2str(game_settings))
	file.close()
