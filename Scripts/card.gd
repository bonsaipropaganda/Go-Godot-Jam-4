extends Area2D

var rng = RandomNumberGenerator.new()
var value : String

var draw_description = false
var description = ""
var description_box = PackedScene
var description_created = false

#DESCRIPTION PATH
const description_path = preload("res://Scenes/description_box.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#$CardSprites.frame = randi() % $CardSprites.sprite_frames.get_frame_count("default")
	match value:
		"more_health":
			Global.more_health += 0.5;
			$CardSprites.set_animation("more_health")
		"more_speed":
			Global.more_speed += 0.5;
			$CardSprites.set_animation("more_speed")
		"more_anger":
			Global.more_anger += 1; #each more anger spawns another anger enemy each time one spawns
			$CardSprites.set_animation("more_anger")
	
	#FIND DESCRIPTION ACCORDING TO VALUE
	match value:
		"more_health":
			description = "Adds 25% more health to enemies"
		"more_speed":
			description = "Adds 25% more speed to enemies"
		"more_anger":
			description = "Increases anger output by 50%"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered():
	$CardSprites.frame = 1
	if not description_created:
		description_box = description_path.instantiate()
		description_box.value = description
		add_child(description_box)
		print("Desc created:" + description_box.value)
		description_created = true

func _on_mouse_exited():
	$CardSprites.frame = 0
	print("Desc destroyed:" + description_box.value)
	description_box.queue_free()
	description_created = false
