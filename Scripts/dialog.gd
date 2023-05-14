extends ColorRect

## basically how this dialog box works is you make an instance of it
# set the name and sprite (depending on who is talking) in the inspector
# set the dialog_array with strings for what you want the character to say

# these variables can be set for each instance of the dialog box
var text_speed = 0.05
var dialog_array = []
var character_name: String
#var character_picture: Texture

# this is the current phrase that is being displayed
var phrase_num = 0
# this determines whether the current phrase typewriter effect is finished
var finished = false

signal go_to_battle

func _ready() -> void:
	# sets the character name, picture, and checks for dialog array
	$Name.text = character_name
	#$SpeakerPortrait.texture = character_picture
	#assert(dialog_array.size() > 0, "Dialog array is empty")
	next_phrase()

# plays the next up phrase
func next_phrase():
	# checks if there are any phrases left
	if phrase_num >= len(dialog_array):
		# if there aren't any dialog box closes
		
		#SWITCH TO BATTLE - SAVE POSITION
		Global.go_to_battle = true
		queue_free()
		return
		
	finished = false
	
	# sets current dialog text and doesn't show any characters
	$Text.text = dialog_array[phrase_num]
	$Text.visible_characters = 0
	
	# shows one more character after brief pause
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		await get_tree().create_timer(text_speed).timeout
	
	finished = true
	phrase_num += 1
	return

func _process(delta: float) -> void:
	# indicator is only visible depending on whether typewriter effect is finished
	$Indicator.visible = finished
	$Indicator/AnimationPlayer.play("Floaty")
	
	# lets you skip the typewriter effect
	if Input.is_action_just_pressed("ui_accept"):
		# if the phrase is finished showing
		if finished:
			next_phrase()
		else:
			# if the phrase is not finished showing show the rest of the phrase
			$Text.visible_characters = len($Text.text)
