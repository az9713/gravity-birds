extends Control

@onready var title_label = $VBoxContainer/TitleLabel
@onready var play_button = $VBoxContainer/PlayButton
@onready var quit_button = $VBoxContainer/QuitButton

func _ready():
	play_button.pressed.connect(_on_play_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func _on_quit_pressed():
	get_tree().quit()
