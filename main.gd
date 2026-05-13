extends Node2D

var level = "uid://ds2wysix487j2"
var buttons = []
var selections = []
var fighters = []
var fighterpaths = {
	"Sly":"res://fighters/sly.tscn"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%UI.hide()
	print(%MainMenu.get_children(true)[2].name)
	buttons = %MainMenu.get_children(true)[2].get_children()[0].get_children()[0].get_children()
	selections = []
	for i in buttons:
		var e = i.get_name().find("Select")
		selections.push_back(i.get_name().erase(e, 6))
		i.connect("pressed", _fighter_select.bind(i))
	%MainMenu.get_child(0, true).connect("pressed", _start)

func _process(delta: float) -> void:
	pass

func _fighter_select(button: Node) -> void:
	fighters.push_back(selections[buttons.find(button)])

func _start() -> void:
	print(fighters)
	$CanvasLayer.hide()
	var next_level = load(level)
	var new_level = next_level.instantiate()
	new_level.choice1 = load(fighterpaths[fighters[0]])
	new_level.choice2 = load(fighterpaths[fighters[1]])
	$LevelLoader.add_child(new_level)
	#var loaded = new_level.get_children(true)
	#var fight1 = load(fighterpaths[fighters[0]])
	#var fight2 = load(fighterpaths[fighters[1]])
	#var next_fight1 = fight1.instantiate()
	#var next_fight2 = fight2.instantiate()
	#loaded[len(loaded)-1].add_child(next_fight1)
	#loaded[len(loaded)-2].add_child(next_fight2)
	#$LevelLoader.get_child(0, true).fighter1 = loaded[len(loaded)-1].get_child(0)
	#$LevelLoader.get_child(0, true).fighter2 = loaded[len(loaded)-2].get_child(0)
