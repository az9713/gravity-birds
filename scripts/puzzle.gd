extends Node2D

@onready var puzzle_game = $PuzzleGame

func _ready():
	if Global.selected_level_path.is_empty():
		Global.selected_level_path = "res://levels/level_01.tres"
	
	var level: LevelData = load(Global.selected_level_path)
	puzzle_game.load_level(level)
	
	puzzle_game.level_won.connect(_on_level_won)
	puzzle_game.hud.undo_pressed.connect(_on_undo_pressed)
	puzzle_game.hud.restart_pressed.connect(_on_restart_pressed)
	puzzle_game.hud.menu_pressed.connect(_on_menu_pressed)

func _on_level_won():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func _on_undo_pressed():
	puzzle_game.undo_move()

func _on_restart_pressed():
	puzzle_game.restart_level()

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")
