extends Area2D

var rng = RandomNumberGenerator.new()
var value : String

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	$CardSprites.frame = 1

func _on_mouse_exited():
	$CardSprites.frame = 0
