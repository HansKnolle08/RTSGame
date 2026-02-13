# Copyright (c) 2026 Hansisi
# MIT License
# res://scripts/menus/options_menu.gd

extends Node

## enums
## consts
## exports
## public vars
## private vars
## onready vars

## Built-In _ready() is called on startup
func _ready() -> void:
	$VolumeSlider/SFXVolumeSilder.value = Globals.volume_sfx
	$VolumeSlider/MusicVolumeSlider.value = Globals.volume_music

## Built-In _process() is called on every frame
func _process(_delta: float) -> void:
	pass

## public methods

## private methods
func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/home_menu.tscn")

func _on_resolution_list_item_selected(index: int) -> void:
	Globals.current_resolution = Globals.RESOLUTIONS[index]
	print("Neue Resolution:", Globals.current_resolution)

func _on_window_mode_list_item_selected(index: int) -> void:
	Globals.current_window_mode = Globals.WINDOW_MODES[index]
	print("Neuer Window_Mode:", Globals.current_window_mode)

func _on_sfx_volume_changed(value: float) -> void:
	Globals.volume_sfx = value
	Globals.save_settings()
	GlobalMusicManager.set_sfx_volume(Globals.volume_sfx)

func _on_music_volume_changed(value: float) -> void:
	Globals.volume_music = value
	Globals.save_settings()
	GlobalMusicManager.set_music_volume(Globals.volume_music)
