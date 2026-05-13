extends BaseLevel
#
func _ready() -> void:
	fighter1 = choice1.instantiate()
	fighter2 = choice2.instantiate()
	%FighterSpawn1.add_child(fighter1)
	%FighterSpawn2.add_child(fighter2)

func _process(delta: float) -> void:
	if fighter1:
		%Camera2D.x1 = fighter1.position.x
		%Camera2D.y1 = fighter1.position.y
	if fighter2:
		%Camera2D.x2 = fighter2.position.x
		%Camera2D.y2 = fighter2.position.y
