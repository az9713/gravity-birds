extends Node2D
class_name PuzzleGame

const TILE_SIZE = 64
const MOVE_DELAY = 0.15
const FALL_DELAY = 0.08

enum TileType { EMPTY = 0, SOLID = 1, VOID = 2, SPIKE = 3 }

const TEX_SOLID := preload("res://assets/art/tile_solid.png")
const TEX_EMPTY := preload("res://assets/art/tile_empty.png")
const TEX_VOID := preload("res://assets/art/tile_void.png")
const TEX_SPIKE := preload("res://assets/art/tile_spike.png")
const TEX_FRUIT := preload("res://assets/art/fruit.png")
const TEX_EXIT_LOCKED := preload("res://assets/art/exit_locked.png")
const TEX_EXIT_OPEN := preload("res://assets/art/exit_open.png")
const TEX_BIRD_HEAD := preload("res://assets/art/bird_head.png")
const TEX_BIRD_BODY := preload("res://assets/art/bird_body.png")
const TEX_BIRD_TAIL := preload("res://assets/art/bird_tail.png")

var level_data: LevelData
var creature_segments: Array[Vector2i] = []
var fruits_remaining: Array[Vector2i] = []
var exit_pos: Vector2i
var state_stack: Array[Dictionary] = []
var is_animating: bool = false
var is_won: bool = false
var is_dead: bool = false

@onready var camera = $Camera2D
@onready var hud = $HUD

signal level_won
signal level_failed

func _ready():
	pass

func load_level(level: LevelData):
	level_data = level
	creature_segments = level.creature_start.duplicate(true)
	fruits_remaining = level.fruits.duplicate(true)
	exit_pos = level.exit_pos
	state_stack.clear()
	is_won = false
	is_dead = false
	
	save_state()
	queue_redraw()
	
	if hud:
		hud.set_level_name(level.level_name)
		hud.update_fruit_count(fruits_remaining.size())

func _input(event):
	if is_animating or is_won or is_dead:
		return
	
	if event.is_action_pressed("ui_left"):
		attempt_move(Vector2i.LEFT)
	elif event.is_action_pressed("ui_right"):
		attempt_move(Vector2i.RIGHT)
	elif event.is_action_pressed("ui_up"):
		attempt_move(Vector2i.UP)
	elif event.is_action_pressed("ui_down"):
		attempt_move(Vector2i.DOWN)
	elif event.is_action_pressed("undo"):
		undo_move()
	elif event.is_action_pressed("restart"):
		restart_level()

func attempt_move(direction: Vector2i):
	if creature_segments.is_empty():
		return
	
	var head_pos = creature_segments[0]
	var new_head_pos = head_pos + direction
	
	# Check if reversing into neck
	if creature_segments.size() > 1 and new_head_pos == creature_segments[1]:
		return
	
	# Check if moving into solid wall
	var tile = level_data.get_tile(new_head_pos.x, new_head_pos.y)
	if tile == TileType.SOLID:
		return
	
	# Valid move - execute simulation
	is_animating = true
	execute_move(direction)

func execute_move(direction: Vector2i):
	# Simulation order: move → pushes → grow → gravity loop → hazards
	
	# 1. Move
	var head_pos = creature_segments[0]
	var new_head_pos = head_pos + direction
	
	var new_segments: Array[Vector2i] = [new_head_pos]
	for i in range(creature_segments.size() - 1):
		new_segments.append(creature_segments[i])
	creature_segments = new_segments
	
	# 2. Pushes (not implemented in v1)
	
	# 3. Grow (check if ate fruit)
	var ate_fruit = false
	for i in range(fruits_remaining.size()):
		if fruits_remaining[i] == new_head_pos:
			fruits_remaining.remove_at(i)
			ate_fruit = true
			if hud:
				hud.update_fruit_count(fruits_remaining.size())
			break
	
	if ate_fruit:
		# Add segment at old tail position after this step
		pass  # Will add after gravity
	
	queue_redraw()
	await get_tree().create_timer(MOVE_DELAY).timeout
	
	# 4. Gravity loop
	var gravity_steps = 0
	var max_gravity_steps = 20
	while gravity_steps < max_gravity_steps:
		var fell = apply_gravity()
		if not fell:
			break
		queue_redraw()
		await get_tree().create_timer(FALL_DELAY).timeout
		gravity_steps += 1
	
	# Apply growth after gravity settles
	if ate_fruit:
		# In a real implementation, track where tail should grow
		# For now, just duplicate last segment
		if creature_segments.size() > 0:
			creature_segments.append(creature_segments[creature_segments.size() - 1])
	
	# 5. Hazards
	check_hazards()
	
	queue_redraw()
	
	if not is_dead:
		save_state()
		check_win_condition()
	
	is_animating = false

func apply_gravity() -> bool:
	var any_fell = false
	
	# Check each segment from tail to head
	for i in range(creature_segments.size() - 1, -1, -1):
		var seg = creature_segments[i]
		var below = seg + Vector2i.DOWN
		
		# Check if segment has support
		var has_support = false
		
		# Check if standing on solid tile
		var tile_below = level_data.get_tile(below.x, below.y)
		if tile_below == TileType.SOLID:
			has_support = true
		
		# Check if standing on another segment
		for j in range(creature_segments.size()):
			if i != j and creature_segments[j] == below:
				has_support = true
				break
		
		# If no support, fall
		if not has_support:
			var tile_at_below = level_data.get_tile(below.x, below.y)
			if tile_at_below != TileType.SOLID:
				creature_segments[i] = below
				any_fell = true
	
	return any_fell

func check_hazards():
	for seg in creature_segments:
		var tile = level_data.get_tile(seg.x, seg.y)
		if tile == TileType.VOID or tile == TileType.SPIKE:
			is_dead = true
			# Soft rewind: undo one step
			await get_tree().create_timer(0.3).timeout
			undo_move()
			is_dead = false
			return

func check_win_condition():
	# Win: all fruit eaten AND head at exit
	if fruits_remaining.is_empty():
		var head = creature_segments[0]
		if head == exit_pos:
			is_won = true
			level_won.emit()

func save_state():
	var state = {
		"creature": creature_segments.duplicate(true),
		"fruits": fruits_remaining.duplicate(true)
	}
	state_stack.append(state)

func undo_move():
	if state_stack.size() <= 1:
		return
	
	state_stack.pop_back()
	var prev_state = state_stack[state_stack.size() - 1]
	
	var restored_creature: Array = prev_state["creature"].duplicate(true)
	creature_segments.assign(restored_creature)
	var restored_fruits: Array = prev_state["fruits"].duplicate(true)
	fruits_remaining.assign(restored_fruits)
	
	if hud:
		hud.update_fruit_count(fruits_remaining.size())
	
	queue_redraw()

func restart_level():
	if state_stack.is_empty():
		return
	
	var initial_state = state_stack[0]
	state_stack.clear()
	state_stack.append(initial_state)
	
	var restored_creature: Array = initial_state["creature"].duplicate(true)
	creature_segments.assign(restored_creature)
	var restored_fruits: Array = initial_state["fruits"].duplicate(true)
	fruits_remaining.assign(restored_fruits)
	is_won = false
	is_dead = false
	
	if hud:
		hud.update_fruit_count(fruits_remaining.size())
	
	queue_redraw()

func _draw():
	if not level_data:
		return
	
	# Draw tiles
	for y in range(level_data.grid_height):
		for x in range(level_data.grid_width):
			var tile = level_data.get_tile(x, y)
			var pos = Vector2(x * TILE_SIZE, y * TILE_SIZE)
			
			match tile:
				TileType.SOLID:
					draw_texture(TEX_SOLID, pos)
				TileType.VOID:
					draw_texture(TEX_VOID, pos)
				TileType.SPIKE:
					draw_texture(TEX_SPIKE, pos)
				TileType.EMPTY:
					pass
	
	# Draw exit
	var exit_draw_pos = Vector2(exit_pos.x * TILE_SIZE, exit_pos.y * TILE_SIZE)
	var exit_tex = TEX_EXIT_OPEN if fruits_remaining.is_empty() else TEX_EXIT_LOCKED
	draw_texture(exit_tex, exit_draw_pos)
	
	# Draw fruits
	for fruit_pos in fruits_remaining:
		var draw_pos = Vector2(fruit_pos.x * TILE_SIZE, fruit_pos.y * TILE_SIZE)
		draw_texture(TEX_FRUIT, draw_pos)
	
	# Draw creature
	for i in range(creature_segments.size()):
		var seg = creature_segments[i]
		var draw_pos = Vector2(seg.x * TILE_SIZE, seg.y * TILE_SIZE)
		
		var is_head = (i == 0)
		var is_tail = (i == creature_segments.size() - 1)
		
		var texture: Texture2D
		if is_head:
			texture = TEX_BIRD_HEAD
		elif is_tail and creature_segments.size() > 1:
			texture = TEX_BIRD_TAIL
		else:
			texture = TEX_BIRD_BODY
		
		# Determine facing direction (check if moving left)
		var flip_h = false
		if is_head and creature_segments.size() > 1:
			var neck_pos = creature_segments[1]
			if seg.x < neck_pos.x:
				flip_h = true
		
		if flip_h:
			draw_set_transform(draw_pos + Vector2(TILE_SIZE, 0), 0, Vector2(-1, 1))
			draw_texture(texture, Vector2.ZERO)
			draw_set_transform(Vector2.ZERO, 0, Vector2.ONE)
		else:
			draw_texture(texture, draw_pos)
