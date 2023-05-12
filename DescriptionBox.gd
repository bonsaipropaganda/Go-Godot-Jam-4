extends Label

var value = ""
var side = ""
var text_margin = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	text = value
	$ColorRect.size = size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().position.x > 0:
		position = get_global_mouse_position() - get_parent().position - Vector2(size.x + text_margin,size.y / 2)
	else:
		position = get_global_mouse_position() - get_parent().position + Vector2(text_margin,- size.y / 2)
	$ColorRect.size = size
