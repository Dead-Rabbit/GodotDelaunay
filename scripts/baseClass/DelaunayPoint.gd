# 用于Point 画布中的点
class_name DelaunayPoint extends Node2D

var id = 0

var x = 0
var y = 0

func _init(x: float, y: float, id: int):
	self.x = x
	self.y = y
	self.id = id
	
func getLocation():
	return Vector2(x, y)

func draw(parent):
	var sp = Sprite.new()
	sp.texture = load("res://sprite/point.png")
	sp.position = Vector2(x, y)
	parent.add_child(sp)
	
func compare(other):
#	return other.x == self.x and other.y == self.y
	return other.id == self.id

static func sort_by_x(a, b):
	if a.x < b.x:
		return true
	return false
