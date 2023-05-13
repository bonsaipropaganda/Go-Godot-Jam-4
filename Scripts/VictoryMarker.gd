extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#MOVE VICTORYBAR ACCORDING TO HEALTH
	position.x = ($"../..".victory_score * 60) / $"../..".total_victory_score
