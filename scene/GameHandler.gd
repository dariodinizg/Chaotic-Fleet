extends Node2D

var game_settings
var configFile = "game_settings"

var start_config = {
	"game": {
		"bgMusic": 6.5,
		"sfxVol": -14,
		"is_sfx_on": true,
		"is_game_music_on": true,
	},
	"menu": {
		"currentSongPosition": 1.2829,
		"is_musicOn": 1,
		"musicVol": -3.5
	}
}


func _ready():
	game_settings = loadConfigFile()
	if typeof(game_settings) != TYPE_DICTIONARY:
		pass
		game_settings = start_config
		print("Config file is missing. Config file created based on factory settings")
	
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
