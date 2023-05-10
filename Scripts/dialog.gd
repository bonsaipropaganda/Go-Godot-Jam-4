extends ColorRect

## basically how this dialog box works is you make an instance of it
# set the name and sprite (depending on who is talking) in the inspector
# set the dialog_array with strings for what you want the character to say

# these variables can be for each instance of the dialog box
@export var text_speed = 0.05
@export var dialog_array = []
@export var character_name: String
@export var character_picture: Texture

var dialog
var phrase_num = 0

func _ready() -> void:
	$Name.text = character_name
	$SpeakerPortrait.texture = character_picture
	$TextTimer.wait_time = text_speed
	assert(dialog_array.size() > 0, "Dialog array is empty")
	dialog = get_dialog()

func get_dialog():
	if dialog_array:
		return dialog_array[phrase_num]

func _process(delta: float) -> void:
	$Text.text = dialog
