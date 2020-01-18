"""
	Game.gd
	Manages the game by, storing, displaying and updating 
			the scores of players, reseting the ball, and 
			displaying the endscreen when a player scores
			3.
	
	Signals
		rematch
		to_menu
	
	Properties
	- p1_score: int, score counter for player on left
	- p2_score: int, score counter for player on right
"""
extends Node2D


signal rematch
signal to_menu

var _p1_score: int = 0
var _p2_score: int = 0


func _ready() -> void:
	if $EndScreen.connect("rematch", self, "_on_rematch") == -1:
		print("Error with rematch")
	if $EndScreen.connect("to_menu", self, "_on_to_menu") == -1:
		print("Error with menu")


func _on_GoalLeft_area_entered(area: Area2D) -> void:
	if "Ball" in area.name:
		if(self.update_score("p2")):
			$Ball.position = Vector2(256, 150)


func _on_GoalRight_area_exited(area: Area2D) -> void:
	if "Ball" in area.name:
		if(self.update_score("p1")):
			$Ball.position = Vector2(256, 150)



func update_score(scorer: String) -> bool:
	if scorer == "p1":
		self._p1_score += 1
	elif scorer == "p2":
		self._p2_score += 1
	
	$Control/LblScores.text = "Player 1: %d | Player 2: %d" % [
			self._p1_score, self._p2_score]
	
	if self._p1_score >= 3 or self._p2_score >= 3:
		self._end_game()
		return false
	return true


func _end_game() -> void:
	$EndScreen.get_node("VBoxContainer/P1Score").text = "Player 1: " + str(self._p1_score)
	$EndScreen.get_node("VBoxContainer/P2Score").text = "Player 2: " + str(self._p2_score)

	if self._p1_score > self._p2_score:
		$EndScreen.get_node("VBoxContainer/Winner").text = "Player 1 Wins"
	else:
		$EndScreen.get_node("VBoxContainer/Winner").text = "Computer Wins"
	
	self.remove_child($Control)
	self.remove_child($Player1)
	var other_player: Node = $Player2 if self.has_node("Player2") else $PlayerAI
	self.remove_child(other_player)
	$EndScreen.show()


func _on_rematch() -> void:
	self.emit_signal("rematch", name)


func _on_to_menu() -> void:
	self.emit_signal("to_menu", name)