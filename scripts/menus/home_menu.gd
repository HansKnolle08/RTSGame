# Copyright (c) 2026 Hansisi
# MIT License
# res://scripts/menus/home_menu.gd

extends Node

## enums
## consts
## exports
## public vars
## private vars
## onready vars

## Built-In _ready() is called on startup
func _ready() -> void:
	_set_window_title()
	GlobalMusicManager.music_loader("res://assets/aud/ost/copyright/menu_theme_1.ogg", Globals.volume_general * Globals.volume_music)

## Built-In _process() is called on every frame
func _process(_delta: float) -> void:
	pass

## public methods

## private methods
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/options_menu.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _set_window_title(title: String = Globals.GAME_NAME):
	await get_tree().create_timer(0.1).timeout
	DisplayServer.window_set_title(title)
