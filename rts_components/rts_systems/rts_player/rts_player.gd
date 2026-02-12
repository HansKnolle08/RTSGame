# Copyright (c) 2026 Hansisi
# MIT License
# res://scripts/rts_components/rts_player/rts_player.gd

extends Node

## consts
const TYPE_HINT_RTS_CAMERA: Script = preload("../rts_camera/rts_camera.gd")
const TYPE_HINT_RTS_SELECTION_MANAGER: Script = preload("../rts_selection_manager/rts_selection_manager.gd")

## public vars
var mouse_dragbox_start_position: Vector2 = Vector2.ZERO
var mouse_dragbox_end_position: Vector2 = Vector2.ZERO
var show_dragbox: bool = false

## onready vars
@onready var rts_camera: TYPE_HINT_RTS_CAMERA = $"../RTSCamera"
@onready var rts_selection_manager: TYPE_HINT_RTS_SELECTION_MANAGER = $RTSSelectionManager
@onready var rts_units: Node = $"../RTSUnits"

## Built-In _ready() is called on startup
func _ready() -> void:
	pass

## Built-In _process() is called on every frame
func _process(delta: float) -> void:
	camera_input_handler(rts_camera, delta)
	selection_dragbox()

## public methods
func camera_input_handler(camera:TYPE_HINT_RTS_CAMERA, delta: float):
	camera_pan(camera, delta)
	camera_move(camera, delta)
	camera_rotate(camera, delta)
	camera_zoom(camera, delta)

func camera_pan(camera:TYPE_HINT_RTS_CAMERA, delta: float) -> void:
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CONFINED: return
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	camera.camera_pan(mouse_pos, viewport_size, delta)

func camera_move(camera: TYPE_HINT_RTS_CAMERA, delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO
	if Input.is_action_pressed(&"input_action_camera_forward"): direction.y = -1
	if Input.is_action_pressed(&"input_action_camera_backward"): direction.y = 1
	if Input.is_action_pressed(&"input_action_camera_left"): direction.x = -1
	if Input.is_action_pressed(&"input_action_camera_right"): direction.x = 1
	if direction == Vector2.ZERO: return
	camera.camera_move(direction, delta)

func camera_rotate(camera:TYPE_HINT_RTS_CAMERA, delta: float) -> void:
	var direction: float = 0
	if Input.is_action_pressed(&"input_action_camera_rotate_right"): direction = 1
	if Input.is_action_pressed(&"input_action_camera_rotate_left"): direction = -1
	if !direction: return
	camera.camera_rotate(direction, delta)

func camera_zoom(camera:TYPE_HINT_RTS_CAMERA, delta: float) -> void:
	var direction: float = 0
	if Input.is_action_pressed(&"input_action_camera_zoom_in") or Input.is_action_just_released(&"input_action_camera_zoom_in"): direction = 1
	if Input.is_action_pressed(&"input_action_camera_zoom_out") or Input.is_action_just_released(&"input_action_camera_zoom_out"): direction = -1
	if !direction: return
	camera.camera_zoom(direction, delta)

func selection_dragbox() -> void:
	if Input.is_action_pressed(&"input_action_mouseclick_left"):
		if mouse_dragbox_start_position == Vector2.ZERO:
			mouse_dragbox_start_position = get_viewport().get_mouse_position()
			mouse_dragbox_end_position = mouse_dragbox_start_position
		mouse_dragbox_end_position = get_viewport().get_mouse_position()
		rts_selection_manager.update_selection_rectangle(Rect2(mouse_dragbox_start_position, mouse_dragbox_end_position - mouse_dragbox_start_position).abs())

	if Input.is_action_just_released(&"input_action_mouseclick_left"):
		var dragbox_rectangle: Rect2 = Rect2(mouse_dragbox_start_position, mouse_dragbox_end_position - mouse_dragbox_start_position).abs()
		rts_selection_manager.dragbox_select_objects(rts_units.get_children(), dragbox_rectangle)
		mouse_dragbox_start_position = Vector2.ZERO
		mouse_dragbox_end_position = Vector2.ZERO
		rts_selection_manager.dragbox_hide()
