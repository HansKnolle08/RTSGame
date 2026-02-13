# Copyright (c) 2026 Hansisi
# MIT License
# res://scripts/main/main.gd

extends Node

## Built-In _ready() is called on startup
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	#GlobalMusicManager.stop_music()
	GlobalMusicManager.play_music("res://assets/aud/ost/copyright/ground_theme_1.ogg")

## Built-In _process() is called on every frame
func _process(_delta: float) -> void:
	pass

## private methods
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_released(&"input_action_enter") or Input.is_action_just_released(&"input_action_mouseclick_left"):
		get_viewport().set_input_as_handled()
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

	if Input.is_action_just_released(&"input_action_esc"):
		get_viewport().set_input_as_handled()
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CONFINED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			get_tree().quit()
