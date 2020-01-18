"""
	Main.gd
	Manages the signals for switching scenes.
	
	Properties
	+ scenes: PoolStringArray
	- loaded_scenes: Dictionary, stores the scenes 
			that have been loaded
"""
extends Node2D


export var scenes: PoolStringArray
onready var _loaded_scenes: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _start_game(type: String) -> void:
	var scene = 1 if type == "single-game" else 2
	$Menu.hide()
	var game = load(self.scenes[scene])
	self._loaded_scenes[type] = game.instance()
	self.add_child(self._loaded_scenes[type])
	self._loaded_scenes[type].connect("rematch", self, "_on_rematch")
	self._loaded_scenes[type].connect("to_menu", self, "_on_to_menu")


func _on_BtnSingleGame_button_up() -> void:
	self._start_game("single-game")


func _on_BtnMultiGame_button_up() -> void:
	self._start_game("multi-game")


func _on_BtnQuit_button_up() -> void:
	self.get_tree().quit()


func _on_rematch(name: String) -> void:
	var scene = "single-game" if "SingleGame" in name else "multi-game"
	self._loaded_scenes[scene].queue_free()
	self._start_game(scene)


func _on_to_menu(name: String) -> void:
	print(name)
	var scene = "single-game" if "SingleGame" in name else "multi-game"
	self._loaded_scenes[scene].queue_free()
	$Menu.show()

