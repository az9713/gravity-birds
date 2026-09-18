extends CanvasLayer

@onready var level_name_label = $TopPanel/MarginContainer/HBoxContainer/LevelName
@onready var fruit_icon = $TopPanel/MarginContainer/HBoxContainer/FruitCounter/FruitIcon
@onready var fruit_count_label = $TopPanel/MarginContainer/HBoxContainer/FruitCounter/FruitLabel
@onready var undo_button = $ButtonContainer/UndoButton
@onready var restart_button = $ButtonContainer/RestartButton
@onready var menu_button = $ButtonContainer/MenuButton

signal undo_pressed
signal restart_pressed
signal menu_pressed

func _ready():
	undo_button.pressed.connect(_on_undo_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	menu_button.pressed.connect(_on_menu_pressed)

func set_level_name(name: String):
	level_name_label.text = name

func update_fruit_count(count: int):
	fruit_count_label.text = "%d" % count

func _on_undo_pressed():
	undo_pressed.emit()

func _on_restart_pressed():
	restart_pressed.emit()

func _on_menu_pressed():
	menu_pressed.emit()
