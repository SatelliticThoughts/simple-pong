"""
	Player.gd
	Controller for the player.
	
	Properties
	+ up: String, the up direction button as string
	+ down: String, the down direction button as string
	+ clockwise: String, the clockwise direction button 
			as string
	+ anticlockwise: String, the anticlockwise direction 
			button as string
	- _velocity: Vector2
	+ speed: int
	+ rotate_dir: float
	- _rotate_amt: float
	- _current_angle: float
	- _MAX_ROTATE: float
	+ rally_multiplier: float
"""
extends KinematicBody2D


export var up: String
export var down: String
export var clockwise: String
export var anticlockwise: String

var _velocity: Vector2
export var speed: int

var rotate_dir: float = 0 setget set_rotate_dir, get_rotate_dir
var _rotate_amt: float = .08
var _current_angle: float = 0
const _MAX_ROTATE: float = .4

var rally_multiplier: float = 1 setget set_rally_multiplier


func _physics_process(delta: float) -> void:
	self._velocity = Vector2()
	
	var direction = Vector2(0.0,
		Input.get_action_strength(self.down) 
		- Input.get_action_strength(self.up))
	
	self._velocity = self.speed * direction
	
	if Input.is_action_pressed(self.clockwise):
		if self._current_angle < self._MAX_ROTATE:
			self._current_angle += .1
			self.rotate_dir += self._rotate_amt * self.rally_multiplier
			rotate(self._current_angle)
	elif Input.is_action_pressed(anticlockwise):
		if self._current_angle > -self._MAX_ROTATE:
			self._current_angle -= .1
			self.rotate_dir -= self._rotate_amt * self.rally_multiplier
			rotate(self._current_angle)
	else:
		rotate(self._current_angle * -2.5)
		self._current_angle = 0
		self.rotate_dir = 0
	
	self._velocity = move_and_slide(self._velocity * delta)


func set_rotate_dir(value: float) -> void:
	rotate_dir = value


func get_rotate_dir() -> float:
	return rotate_dir


func set_rally_multiplier(value: float) -> void:
	rally_multiplier = value
