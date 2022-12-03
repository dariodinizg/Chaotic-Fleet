extends Node2D

var game_settings
var configFile = "game_settings.json"

func _ready():
	game_settings = loadJSONConfigFile()

func loadJSONConfigFile():
	var file = File.new()
	file.open(configFile, File.READ)
	var configInfo = parse_json(file.get_as_text())
	file.close()
	return configInfo

func saveJSONConfig():
	var file = File.new()
	file.open(configFile, File.WRITE_READ)
	file.store_line(to_json(game_settings))
	file.close()
