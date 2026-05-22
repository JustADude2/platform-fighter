extends CharacterBody2D

@export var player := 0
@export var spriteframes: SpriteFrames
@export var animationplayer: Node
@export var health := 200
@onready var sprite := %AnimatedSprite2D
@export var hurtbox: Resource = load("res://fighters/sly_hit.tres")
@export var hitting: bool = false
@export var damage := 20
var left := 0.0
var right := 0.0
var up := 0.0
var down := 0.0
var dashing := false
var input: Vector2
var orbs: Array[Area2D] = []
var horizontal: float
var vertical: float
var direction: Vector2
var jumps := 2
var airs := 1
var wait: float = 0
const SPEED := 600.0
const JUMP_VELOCITY := -600.0
const gravity := 1250
var state: STATES = STATES.IDLE
var oldstate: STATES = STATES.IDLE
enum STATES {
	IDLE,
	WALK,
	JUMP,
	FALL,
	JAB,
	SIDE_SPECIAL,
	UP_SPECIAL
}
var anims = {
	STATES.IDLE: &"idle",
	STATES.WALK: &"dash",
	STATES.JUMP: &"jump",
	STATES.FALL: &"fall",
	STATES.SIDE_SPECIAL: &"side_speciale",
	STATES.UP_SPECIAL: &"side_specials",
}


func _ready() -> void:
	%AnimatedSprite2D.sprite_frames = spriteframes
	$HitBox.connect("area_entered", _on_entered)

func _process(delta: float) -> void:
	wait -= delta
	$Sprite2D.frame = player

func _physics_process(delta: float) -> void:
	$HurtBox.damage = damage
	%HurtShape.shape = hurtbox
	if not hitting:
		%HurtShape.shape = load("res://fighters/not_hitting.tres")
	
	sprite.play(anims[state])
	
	if not is_on_floor():
		velocity.y += gravity * delta
		if wait <= 0:
			if velocity.y > 0:
				state = STATES.FALL
			else:
				state = STATES.JUMP
	else:
		dashing = false
		if wait <= 0:
			airs = 1
			if horizontal:
				state = STATES.WALK
			else:
				state = STATES.IDLE
			jumps = 2
	
	if horizontal:
		if (velocity.x < horizontal * SPEED and horizontal >= 0) or (velocity.x > horizontal * SPEED and horizontal <= 0):
			velocity.x = move_toward(velocity.x, horizontal * SPEED, SPEED*delta*8)
		%AnimatedSprite2D.set(&"flip_h", round((horizontal+1)/2))
	elif not dashing:
		velocity.x = move_toward(velocity.x, 0, SPEED*delta*8)
	if wait > 0:
		if direction.x != 0:
			velocity.x = direction.x * (SPEED*1.1)
		if direction.y != 0:
			velocity.y = direction.y * (SPEED*1.1)
	
	for i in orbs:
		if not i.get_overlapping_areas().has($HitBox):
			orbs.erase(i)
	
	if Input.is_action_pressed("grab") and orbs and horizontal and not dashing:
		velocity.x = sqrt(pow(velocity.x, 2) + pow(velocity.y, 2)) * input.x
		position = orbs[0].position*3 - get_parent().get_parent().position + Vector2(0, 64)
		velocity.y = sqrt(pow(velocity.x, 2) + pow(velocity.y, 2)) * input.y
		dashing = true
	
	if health <= 0:
		get_tree().quit()
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.device == player:
		if event.is_action("left"):
			left = event.get_action_strength("left")
		elif event.is_action_released("left"):
			left = 0
		if event.is_action("right"):
			right = event.get_action_strength("right")
		elif event.is_action_released("right"):
			right = 0
		if event.is_action("up"):
			up = event.get_action_strength("up")
		elif event.is_action_released("up"):
			up = 0
		if event.is_action("down"):
			down = event.get_action_strength("down")
		elif event.is_action_released("down"):
			down = 0
		horizontal = right - left
		vertical = up - down
		input = Vector2(horizontal, vertical).limit_length(1)
		if wait <= 0:
			if event.is_action_pressed("jump") and jumps:
				velocity.y = JUMP_VELOCITY
				jumps -= 1
			if event.is_action_pressed("special"):
				if abs(horizontal) > abs(vertical):
					state = STATES.SIDE_SPECIAL
					direction.x = (ceil(horizontal/2)-0.5)*2
					direction.y = 0
					velocity.y = 0
					animationplayer.play("side_special")
					wait = 9.0 / 16.0
					dashing = false
				elif abs(horizontal) <= vertical and airs and vertical:
					state = STATES.UP_SPECIAL
					direction.x = 0
					velocity.x = velocity.x/2
					direction.y = -1.5
					wait = 3.0 / 16.0
					animationplayer.play("up_special")
					airs = 0
					dashing = false

func _on_entered(area: Area2D):
	print("the thing did the")
	if area.is_in_group("HurtBox") and area.get_parent() != self:
		health -= area.final
		print(health)
	if area.is_in_group("Orbs"):
		orbs.push_back(area)
