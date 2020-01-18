"""
	Ball.gd
	Controls the Ball's velocity and audio when interacting
			with other objects.
	
	Properties
	- velocity: Vector2, stores Body's direction and speed.
	+ speed: float, speed at which the Body can travel.
	- direction: int, determines X-Axis direction.
	- angle: float, determines the Y-Axis velocity and direction
"""
extends KinematicBody2D


var _velocity: Vector2
export var speed: float
var _direction: int = 1
var _angle: float = 0.0


func _physics_process(delta: float) -> void:
	self._velocity = Vector2(self.speed * self._direction, self._angle)
	self._velocity = self.move_and_slide(self._velocity * delta)


func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	$Bump.play()
	if "Player" in body.name:
		self.speed += 1000
		self._direction *= -1
		self._angle = (
				body.rotate_dir * self.speed 
					if "Player1" in body.name 
					else body.rotate_dir * -self.speed
				)
		
		body.rally_multiplier += 1
	
	if "Wall" in body.name:
		self._angle *= -1
