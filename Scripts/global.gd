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

#DECK STUFF
#VARIABLES
var hand_size = 4
var deck = []
var hand = []
var discard = []

#GLOBAL CARD EFFECT VARIABLES
var more_enemy = 0
var more_health = 0
var more_speed = 0
var more_fear = 0
var more_anger = 0
var more_anxiety = 0

#GLOBAL CARD MULTIPLIERS PER EFFECT NUMBER ABOVE
var speed_multiplier = 0.25
var health_multiplier = 0.25

#OVERWORLD SAVE USED FOR TRANSITIONING IN AND OUT OF BATTLES
var go_to_battle = false
var player_position = Vector2(0,0)


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
