extends Control

@export var fighter1: Node2D
@export var fighter2: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fighter1:
		$Health1.text = str(fighter1.base.health) + " Health"
	if fighter2:
		$Health2.text = str(fighter2.base.health) + " Health"
