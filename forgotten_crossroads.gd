extends BaseLevel

signal done(level: Node2D)

func _ready() -> void:
	fighter1 = choice1.instantiate()
	fighter2 = choice2.instantiate()
	%FighterSpawn1.add_child(fighter1)
	%FighterSpawn2.add_child(fighter2)
	fighter1.base.player = 0
	fighter2.base.player = 1
	done.emit(self)

func _process(delta: float) -> void:
	%Camera2D.x1 = fighter1.x
	%Camera2D.y1 = fighter1.y
	%Camera2D.x2 = fighter2.x
	%Camera2D.y2 = fighter2.y
