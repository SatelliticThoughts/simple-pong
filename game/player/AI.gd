"""
	AI.gd
	Controls the Computer opponent for SingleGame.
	Gets Ball position and and moves on the Y-Axis to intercept it.
	
	Properties
		- velocity: Vector2, stores Body's direction and speed
		+ speed: int, the speed at which the body can travel
		- rotate_dir, the direction the ball will use to determine it's 
				Y-Axis
		+ rally_multiplier: float, rally_muliplier determines ball speed 
				and rotate_dir's effect.
"""
extends KinematicBody2D


var _velocity: Vector2
var speed: int = 1000
var rotate_dir: float = 0.0
var rally_multiplier: float = 1.0 setget set_rally_multiplier


func _physics_process(delta: float) -> void:
	self._velocity = Vector2()
	var direction = Vector2(0.0, 
			self.get_node("../Ball").position.y - self.position.y)
	self.rotate_dir = 0.0
	self._velocity = self.speed * direction
	self._velocity = self.move_and_slide(self._velocity * delta)


func set_rally_multiplier(value: float) -> void:
	rally_multiplier = value
