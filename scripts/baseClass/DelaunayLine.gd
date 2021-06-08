class_name DelaunayLine extends Node2D

var DelaunayPoint = load("res://scripts/baseClass/DelaunayPoint.gd")

var point1 : DelaunayPoint
var point2 : DelaunayPoint

func _init(point1, point2):
	self.point1 = point1
	self.point2 = point2

func compare(other : DelaunayLine):
	var point1 = other.point1
	var point2 = other.point2
	return (point1.compare(self.point1) and point2.compare(self.point2)) \
			|| (point2.compare(self.point1) and point1.compare(self.point2))
