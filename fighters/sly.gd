extends Node2D

@export var x: float
@export var y: float
@export var base: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Fighter.spriteframes = load("res://fighters/sly_sprite.tres")
	x = %Fighter.global_position.x
	y = %Fighter.global_position.y
	%Fighter.animationplayer = $AnimationPlayer
	base = %Fighter


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	x = %Fighter.global_position.x
	y = %Fighter.global_position.y
