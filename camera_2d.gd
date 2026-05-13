extends Camera2D

@export var x1: float = 0
@export var y1: float = 0
@export var x2: float = 0
@export var y2: float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = (x1+x2)/2 
	position.y = (y1+y2)/2
