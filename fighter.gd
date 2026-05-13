extends CharacterBody2D

@export var player := 0
@export var animation: StringName = &"idle"
@export var spriteframes: SpriteFrames
var jumps := 2
var wait: float = 0
const SPEED = 300.0
const JUMP_VELOCITY = -800.0
var state: STATES = STATES.IDLE
enum STATES {
	IDLE,
	WALK,
	JUMP,
	FALL,
	JAB,
	SPECIAL
}


func _ready() -> void:
	%AnimatedSprite2D.sprite_frames = spriteframes

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		if wait == 0:
			if velocity.y <= 0:
				state = STATES.FALL
			else:
				state = STATES.JUMP
	else:
		jumps = 2
	
	if Input.is_action_just_pressed("jump") and jumps:
		velocity.y = JUMP_VELOCITY
		jumps -= 1
	
	var horizontal := Input.get_axis("left", "right")
	if horizontal:
		velocity.x = horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
