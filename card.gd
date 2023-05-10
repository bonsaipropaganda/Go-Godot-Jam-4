extends Area2D

var rng = RandomNumberGenerator.new()
   
# Called when the node enters the scene tree for the first time.
func _ready():
	$CardSprites.frame = randi() % $CardSprites.sprite_frames.get_frame_count("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
