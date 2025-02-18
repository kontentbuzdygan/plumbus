@tool
extends Node

@export var source_tilemap: TileMapLayer
@export var target_tilemap: TileMapLayer
@export var margin_top: int
@export var margin_right: int
@export var margin_bottom: int
@export var margin_left: int

const INSPECTOR_BUTTON_LABEL := "Recalculate tiles"

const CELL_NEIGHBORS := {
    "TOP_SIDE": TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_SIDE,
    "TOP_RIGHT_CORNER": TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_RIGHT_CORNER,
    "RIGHT_SIDE": TileSet.CellNeighbor.CELL_NEIGHBOR_RIGHT_SIDE,
    "BOTTOM_RIGHT_CORNER": TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_RIGHT_CORNER,
    "BOTTOM_SIDE": TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_SIDE,
    "BOTTOM_LEFT_CORNER": TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_LEFT_CORNER,
    "LEFT_SIDE": TileSet.CellNeighbor.CELL_NEIGHBOR_LEFT_SIDE,
    "TOP_LEFT_CORNER": TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_LEFT_CORNER,
}


func _inspector_button_pressed() -> void:
    var used_rect := source_tilemap.get_used_rect()
    var generation_rect := Rect2i(
        used_rect.position - Vector2i(margin_left, margin_top),
        used_rect.size + Vector2i(margin_left + margin_right, margin_top + margin_bottom),
    )

    var source_id := target_tilemap.tile_set.get_source_id(0)
    var source := target_tilemap.tile_set.get_source(source_id)

    for x in range(generation_rect.size.x):
        for y in range(generation_rect.size.y):
            var coord := generation_rect.position + Vector2i(x, y)
            _generate_tile(coord, source_id, source)


func _generate_tile(coord: Vector2i, source_id: int, source: TileSetAtlasSource) -> void:
    var tile := source_tilemap.get_cell_tile_data(coord)
    var terrain := tile.terrain if tile else -1

    var peering_bits := {}
    for neighbor_key in CELL_NEIGHBORS:
        var neighbor_coord := source_tilemap.get_neighbor_cell(coord, CELL_NEIGHBORS[neighbor_key])
        var neighbor_tile = source_tilemap.get_cell_tile_data(neighbor_coord)

        peering_bits[neighbor_key] = -1 if neighbor_tile == null else neighbor_tile.terrain

    var target_tile_id := _find_tile_id_for_terrain(source, terrain, peering_bits)
    target_tilemap.set_cell(coord, source_id, target_tile_id, 0)


func _find_tile_id_for_terrain(source: TileSetAtlasSource, terrain: int, peering_bits: Dictionary) -> Vector2i:
    for tile_index in range(source.get_tiles_count()):
        var tile_id := source.get_tile_id(tile_index)
        var tile := source.get_tile_data(tile_id, 0)

        if tile.terrain == terrain and _peering_bits_match(peering_bits, tile):
            return tile_id

    return Vector2i(-1, -1)


func _peering_bits_match(peering_bits: Dictionary, tile: TileData) -> bool:
    for neighbor_key in peering_bits:
        if not tile.is_valid_terrain_peering_bit(CELL_NEIGHBORS[neighbor_key]) \
            or peering_bits[neighbor_key] != tile.get_terrain_peering_bit(CELL_NEIGHBORS[neighbor_key]):
            return false

    return true
