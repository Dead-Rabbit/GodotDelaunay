class_name DelaunayTriangle extends Node2D

var DelaunayPoint = load("res://scripts/baseClass/DelaunayPoint.gd")
var DelaunayLine = load("res://scripts/baseClass/DelaunayLine.gd")

# vertices
var point1 : DelaunayPoint
var point2 : DelaunayPoint
var point3 : DelaunayPoint

var line1 : DelaunayLine
var line2 : DelaunayLine
var line3 : DelaunayLine

# 圆心和半径
var center : Vector2
var radius: float

var line2D : Line2D

# 初始化
func _init(point1 : DelaunayPoint, point2 : DelaunayPoint, point3 : DelaunayPoint):
	self.point1 = point1
	self.point2 = point2
	self.point3 = point3
	self.line1 = DelaunayLine.new(self.point1, self.point2)
	self.line2 = DelaunayLine.new(self.point2, self.point3)
	self.line3 = DelaunayLine.new(self.point3, self.point1)
	
	
func draw(parent):
	line2D = Line2D.new()
	line2D.width = 1
	line2D.default_color = Color.white
	line2D.add_point(self.point1.getLocation())
	line2D.add_point(self.point2.getLocation())
	line2D.add_point(self.point3.getLocation())
	
	
# 判断点是否在外接圆右侧
func checkIfPointOutSideOnRight(point):
	return point.x > center.x + radius
	
# 判断点是否在外接圆内
func checkIfPointInside(point : DelaunayPoint):
	var pos = Vector2(point.x, point.y)
	return center.distance_to(pos) <= radius
	
# 计算三角形的圆心和半径
func calculateCenterAndRadius():
	var a1 = point2.x - point1.x
	var b1 = point2.y - point1.y
	var c1 = (a1 * a1 + b1 * b1) / 2;

	var a2 = point3.x - point1.x
	var b2 = point3.y - point1.y
	var c2 = (a2 * a2 + b2 * b2) / 2;

	var d = a1 * b2 - a2 * b1;

	var x = point1.x + (c1 * b2 - c2 * b1) / d;
	var y = point1.y + (a1 * c2  - a2 * c1) / d;
	center = Vector2(x, y)
	radius = center.distance_to(Vector2(point1.x, point1.y))
