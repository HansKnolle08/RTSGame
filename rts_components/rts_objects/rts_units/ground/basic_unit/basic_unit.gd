# Copyright (c) 2026 Hansisi
# MIT License
# res://rts_components/rts_objects/rts_units/ground/basic_unit/basic_unit.gd

extends Node

## enums
## consts
## exports
## public vars
var selected: bool = false:
	set(new_value):
		selected = new_value
		if selected:
			selection_sprite.show()
		else:
			selection_sprite.hide()
	get():return selected

## private vars
## onready vars
@onready var selection_sprite: Sprite3D = $CircleSelection

## built-in override methods

## Built-In _ready() is called on startup
func _ready() -> void:
	selected = false

## Built-In _process() is called on every frame
func _process(delta: float) -> void:
	pass

## public methods

## private methods
