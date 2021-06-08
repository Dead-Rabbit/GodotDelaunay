# 用于Point 画布中的点
class_name DelaunayPoint extends Node2D
	
var x = 0
var y = 0

func _init(x: float, y: float):
	self.x = x
	self.y = y

func draw(parent):
	var sp = Sprite.new()
	sp.texture = load("res://sprite/point.png")
	sp.position = Vector2(x, y)
	parent.add_child(sp)
