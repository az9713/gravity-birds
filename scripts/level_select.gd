extends Control

const LEVEL_FILES = [
	"res://levels/level_01.tres",
	"res://levels/level_02.tres",
	"res://levels/level_03.tres",
	"res://levels/level_04.tres",
	"res://levels/level_05.tres",
]

@onready var level_list = $VBoxContainer/ScrollContainer/LevelList
@onready var back_button = $VBoxContainer/BackButton

var level_button_scene = preload("res://scenes/level_button.tscn")

func _ready():
	back_button.pressed.connect(_on_back_pressed)
	populate_level_list()

func populate_level_list():
	for i in range(LEVEL_FILES.size()):
		var level_path = LEVEL_FILES[i]
		if ResourceLoader.exists(level_path):
			var level: LevelData = load(level_path)
			var button = level_button_scene.instantiate()
			button.text = "%d. %s" % [i + 1, level.level_name]
			button.pressed.connect(_on_level_selected.bind(level_path))
			level_list.add_child(button)

func _on_level_selected(level_path: String):
	Global.selected_level_path = level_path
	get_tree().change_scene_to_file("res://scenes/puzzle.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
