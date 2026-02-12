# Copyright (c) 2026 Hansisi
# MIT License
# res://scripts/rts_components/rts_camera/rts_camera.gd

extends Node3D

## consts
const CAMERA_PAN_MARGIN: float = 5.0
const CAMERA_ROTATION_VELOCITY: float = 1.0
const CAMERA_ZOOM_SPEED: float = 4.0
const CAMERA_ZOOM_RANGE: Vector2 = Vector2(50, 200)
const CAMERA_MOVE_SPEED: Vector2 = Vector2(25, 100)

## public vars
var cam_movement_velocity: Vector3 = Vector3.ZERO
var cam_zoom_velocity: float = 0.0

## onready vars
@onready var Camera: Camera3D = $Camera3D

## Built-In _ready() is called on startup
func _ready() -> void:
	_setup_camera(Camera)

## Built-In _process() is called on every frame
func _process(_delta: float) -> void:
	_apply_movements_velocity()
	_apply_zoom_velocity()

## public methods
func camera_pan(mouse_pos: Vector2, viewport_size: Vector2, delta: float) -> void:
	if mouse_pos.x < CAMERA_PAN_MARGIN: cam_movement_velocity.x = -1 * delta
	if mouse_pos.y < CAMERA_PAN_MARGIN: cam_movement_velocity.z = -1 * delta
	if mouse_pos.x > viewport_size.x - CAMERA_PAN_MARGIN: cam_movement_velocity.x = 1 * delta
	if mouse_pos.y > viewport_size.y - CAMERA_PAN_MARGIN: cam_movement_velocity.z = 1 * delta

func camera_move(direction: Vector2, delta: float) -> void:
		cam_movement_velocity.z = direction.y * delta
		cam_movement_velocity.x = direction.x * delta

func camera_rotate(direction: float, delta: float) -> void:
	global_rotation.y += (CAMERA_ROTATION_VELOCITY * delta) * direction

func camera_zoom(direction: float, delta: float) -> void:
		cam_zoom_velocity -= ((CAMERA_ZOOM_SPEED * 25) * delta) * direction

## private methods
func _setup_camera(cam: Camera3D) -> void:
	cam.fov = 12.0
	cam.position.y = 3.0
	cam.rotation.x = deg_to_rad(-30)
	rotation.y = deg_to_rad(-45)
	cam.translate_object_local(Vector3(0, 0, 100))

func _apply_movements_velocity() -> void:
	if cam_movement_velocity != Vector3.ZERO:
		var camera_zoom_speed: float = remap(
			Camera.position.z, 
			CAMERA_ZOOM_RANGE.x, CAMERA_ZOOM_RANGE.y, 
			CAMERA_MOVE_SPEED.x, CAMERA_MOVE_SPEED.y
		)
		translate_object_local(cam_movement_velocity * camera_zoom_speed)
		cam_movement_velocity = Vector3.ZERO

func _apply_zoom_velocity(cam: Camera3D = Camera) -> void:
	if cam_zoom_velocity != 0:
		var calculated_zoom: float = cam.position.z + cam_zoom_velocity
		if (calculated_zoom > CAMERA_ZOOM_RANGE.x) and (calculated_zoom < CAMERA_ZOOM_RANGE.y):
			cam.translate_object_local(Vector3(0, 0, cam_zoom_velocity))
	cam_zoom_velocity = 0
