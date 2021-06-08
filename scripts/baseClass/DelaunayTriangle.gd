class_name DelaunayTriangle extends Node2D

var DelaunayPoint = load("res://scripts/baseClass/DelaunayPoint.gd")

var point1 : DelaunayPoint
var point2 : DelaunayPoint
var point3 : DelaunayPoint

func _init(pos1 : Vector2, pos2 : Vector2, pos3 : Vector2):
	point1 = DelaunayPoint.new(pos1.x, pos1.y)
	point2 = DelaunayPoint.new(pos2.x, pos2.y)
	point3 = DelaunayPoint.new(pos3.x, pos3.y)
