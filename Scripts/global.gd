extends Node

var attackDamage = 50
var play_sfx = true
var play_music = true
var fullscreen = false
var version = null
var paused = false
var dead = false
var show_debug_ui = false
var camera

#GLOBAL CARD EFFECT VARIABLES
var more_enemy = 1
var more_health = 1
var more_speed = 1
var more_fear = 1
var more_anger = 1
var more_anxiety = 1


func _ready() -> void:
	pass

func load_settings() -> void:
	pass
	
func save_settings() -> void:
	pass

## val is a bool representing whether or not to toggle on fullscreen
func set_fullscreen(val: bool) -> void:
	fullscreen = val
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

## Assigns the value to the Global setting variable.
## Defaults to saving all settings after one gets set, but can be disabled
## with the `save` argument.
func set_setting(setting: String, val, save := true) -> void:
	self[setting] = val
	if setting == "fullscreen":
		set_fullscreen(val)

	if save:
		save_settings()
		

func get_setting(setting: String):
	return self[setting]
