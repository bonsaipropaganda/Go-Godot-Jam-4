extends Area2D

var rng = RandomNumberGenerator.new()
var value : String

# Called when the node enters the scene tree for the first time.
func _ready():
	$CardSprites.frame = randi() % $CardSprites.sprite_frames.get_frame_count("default")
	match value:
		"more_health":
			Global.more_health += 0.5;
		"more_speed":
			Global.more_speed += 0.5;
			print("more speed!")
		"more_enemies":
			Global.more_enemies += 0.5;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
