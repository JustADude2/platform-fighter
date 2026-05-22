extends Area2D

@export var final := 20
@export var damage: int = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	final = damage + log(get_parent().velocity.length()+1)
