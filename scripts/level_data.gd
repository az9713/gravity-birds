extends Resource
class_name LevelData

@export var level_name: String = "Untitled Level"
@export var grid_width: int = 10
@export var grid_height: int = 8
@export var tiles: Array[int] = []  # 0=empty, 1=solid, 2=void, 3=spike
@export var fruits: Array[Vector2i] = []
@export var exit_pos: Vector2i = Vector2i(0, 0)
@export var creature_start: Array[Vector2i] = []  # head at [0], tail segments follow

enum TileType {
	EMPTY = 0,
	SOLID = 1,
	VOID = 2,
	SPIKE = 3
}

func get_tile(x: int, y: int) -> int:
	if x < 0 or x >= grid_width or y < 0 or y >= grid_height:
		return TileType.VOID
	var index = y * grid_width + x
	if index >= tiles.size():
		return TileType.EMPTY
	return tiles[index]

func set_tile(x: int, y: int, tile_type: int) -> void:
	if x < 0 or x >= grid_width or y < 0 or y >= grid_height:
		return
	var index = y * grid_width + x
	while tiles.size() <= index:
		tiles.append(TileType.EMPTY)
	tiles[index] = tile_type
