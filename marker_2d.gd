extends Marker2D

var i = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var v = Input.get_vector("left", "right", "up", "down")
	position.x += v.x * delta
	position.y += v.y * delta

func _input(event: InputEvent) -> void:
	if event.device != 0:
		self.get_child(0).show()
	else:
		i += 1
		self.get_child(0).hide()
