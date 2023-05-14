extends Area2D

var rng = RandomNumberGenerator.new()
var value : String
var card_slot : int

var draw_description = false
var description = ""
var description_box = PackedScene
var description_created = false

@onready var deck_position = Vector2(142,0)

#SIGNAL FOR CARD SLOT DISCARD
signal discard_card(card_slot)


#DESCRIPTION PATH
const description_path = preload("res://Scenes/description_box.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#$CardSprites.frame = randi() % $CardSprites.sprite_frames.get_frame_count("default")	
	#FIND DESCRIPTION ACCORDING TO VALUE
	match value:
		"more_health":
			description = "Adds 25% more health to enemies"
		"more_speed":
			description = "Adds 25% more speed to enemies"
		"more_anger":
			description = "Increases anger output by 50%"

	#SLIDE IN NEW CARD FROM DECK
	var start_position = position
	position = deck_position
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "position", start_position, 0.5)
	
	if Global.win:
		$CardSprites/Discard.queue_free()
		#$SlideInAndOut.animation = "float"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#ON WIN SCREEN - If clicked card, remove card from hand go to main scene
	if Global.win and Input.is_action_just_pressed("left_click") and description_created:
		print("clicked!")
		#REMOVE CARD FROM HAND
		Global.hand.pop_at(card_slot)
		Global.win = false
		get_tree().call_group("card","remove_card_effect")
		get_tree().change_scene_to_file("res://Scenes/scene_overworld.tscn")

func _on_mouse_entered():
	$CardSprites.frame = 1
	if not description_created:
		description_box = description_path.instantiate()
		description_box.value = description
		add_child(description_box)
		#print("Desc created:" + description_box.value)
		description_created = true

func _on_mouse_exited():
	$CardSprites.frame = 0
	#print("Desc destroyed:" + description_box.value)
	description_box.queue_free()
	description_created = false


func _on_discard_pressed():
	if not Global.win:
		emit_signal("discard_card",card_slot)
		
		#REMOVE EFFECT OF CARD
		match value:
			"more_health":
				Global.more_health -= 1; # increases health of mobs by 25%
			"more_speed":
				Global.more_speed -= 1; # increases speed of mobs by 25%
			"more_anger":
				Global.more_anger -= 1; # increases anger spawn rate by 25%
				
		print("discared!")
		$CardSprites/Discard.hide()
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_EXPO)
		tween.tween_property(self, "position", deck_position, 0.5)
		tween.tween_callback(self.queue_free)


func _on_discard_delay_timeout():
	match value:
		"more_health":
			Global.more_health += 1; # increases health of mobs by 25%
			$CardSprites.set_animation("more_health")
		"more_speed":
			Global.more_speed += 1; # increases speed of mobs by 25%
			$CardSprites.set_animation("more_speed")
		"more_anger":
			Global.more_anger += 1; # increases anger spawn rate by 25%
			$CardSprites.set_animation("more_anger")
			
func remove_card_effect():
	#REMOVE EFFECT OF CARD
	match value:
		"more_health":
			Global.more_health -= 1; # increases health of mobs by 25%
		"more_speed":
			Global.more_speed -= 1; # increases speed of mobs by 25%
		"more_anger":
			Global.more_anger -= 1; # increases anger spawn rate by 25%
			
	print("effect removed")
