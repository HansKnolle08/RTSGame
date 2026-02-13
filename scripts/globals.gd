# Copyright (c) 2026 Hansisi
# MIT License
# res://scripts/global/globals.gd

extends Node

## consts
const BASE_NAME: String = "RTS Game"
const VERSION: String = "0.3.3.alpha.windows"
const GAME_NAME: String = BASE_NAME + " " + "("+ VERSION +")"

const OST_COPYRIGHT_DIR := "/copyright/"
const OST_FALLBACK_DIR := "/fallback/"

const SETTINGS_PATH := "user://settings.cfg"

const RESOLUTIONS: Dictionary = {
	0: "1280x720",
	1: "1366x768",
	2: "1600x900",
	3: "1920x1080",
	4: "2560x1440",
	5: "3840x2160"
}
const WINDOW_MODES: Dictionary = {
	0: "Windowed",
	1: "Borderless",
	2: "Fullscreen"
}

## public vars
var volume_sfx: float = 2.0
var volume_music: float = 2.0

var current_window_mode: String = WINDOW_MODES[0]
var current_resolution: String = RESOLUTIONS[0]

## Built-In _ready() is called on startup
func _ready() -> void:
	load_settings()

## public methods
func save_settings() -> void:
	var config = ConfigFile.new()

	config.set_value("audio", "volume_music", volume_music)
	config.set_value("audio", "volume_sfx", volume_sfx)

	var err = config.save(SETTINGS_PATH)
	if err != OK:
		push_error("Failed to save settings!")

func load_settings() -> void:
	var config = ConfigFile.new()

	var err = config.load(SETTINGS_PATH)
	if err != OK:
		print("Settings file not found. Using defaults.")
		return

	volume_music = config.get_value("audio", "volume_music", 1.0)
	volume_sfx = config.get_value("audio", "volume_sfx", 1.0)
