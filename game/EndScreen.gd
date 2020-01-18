"""
	EndScreen.gd
	Handles the signals to be emitted when button is pressed.
	
	Signals
		rematch
		to_menu
"""
extends Control


signal rematch
signal to_menu


func _on_BtnRematch_button_up() -> void:
	self.emit_signal("rematch")


func _on_BtnQuitToMenu_button_up() -> void:
	self.emit_signal("to_menu")
